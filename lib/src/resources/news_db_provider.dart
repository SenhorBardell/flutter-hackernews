import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'repository.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documents = await getApplicationDocumentsDirectory();
    final path = join(documents.path, 'items.db');
    db = await openDatabase(path, version: 1, onOpen: (Database newDB) {
      newDB.delete('Items');
    }, onCreate: (Database newDb, int version) {
      newDb.execute('''
        create table Items (
          id integer primary key,
          type text,
          by text,
          time integer,
          text text,
          parent integer,
          kids blob,
          dead integer,
          deleted integer,
          url text,
          score integer,
          title text,
          descendants integer
        )
      ''');
    });
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db
        .query('Items', columns: null, where: 'id = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert('Items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<int>> fetchTopIds() {
    // TODO implement this
    return null;
  }

  Future<int> clear() {
    return db.delete('Items');
  }
}

final newsDbProvider = NewsDbProvider();
