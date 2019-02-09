import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'dart:async';
import '../models/item_model.dart';
import 'loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (BuildContext context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        final item = snapshot.data;

        final children = <Widget>[
          ListTile(
            title: buildText(item),
            subtitle: item.by == "" ? Text('deleted') : Text(item.by),
            contentPadding: EdgeInsets.only(right: 16, left: depth * 16.0),
          ),
          Divider()
        ];

        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget buildText(ItemModel item) {
    final text = HtmlUnescape()
        .convert(item.text)
        .replaceAll('<p>', '\n\n')
        .replaceAll('</p>', '');
    return Text(text);
  }
}
