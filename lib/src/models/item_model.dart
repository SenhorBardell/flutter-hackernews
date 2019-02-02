class ItemModel {
  final int id;
  final bool deleted;
  final String type;
  final String by;
  final int time;
  final String text;
  final bool dead;
  final int parent;
  final List<dynamic> kids;
  final String url;
  final int score;
  final String title;
  final int descendants;

  ItemModel.fromJson(Map<String, dynamic> data)
      : id = data['id'],
        deleted = data['deleted'],
        type = data['type'],
        by = data['by'],
        time = data['time'],
        text = data['text'],
        dead = data['dead'],
        parent = data['parent'],
        kids = data['kids'],
        url = data['url'],
        score = data['score'],
        title = data['title'],
        descendants = data['descendants'];
}
