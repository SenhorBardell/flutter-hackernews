import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/item_model.dart';

final _domain = 'https://hacker-news.firebaseio.com';
final _version = 'v0';

class NewsApiProvider {
  Client client = Client();

  fetchTopIds() async {
    final response = await client.get('$_domain/$_version/topstories.json');
    final ids = json.decode(response.body);
    return ids;
  }

  fetchItem(int id) async {
    final response = await client.get('$_domain/$_version/item/$id.json');
    final data = json.decode(response.body);

    return ItemModel.fromJson(data);
  }
}
