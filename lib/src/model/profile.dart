import 'dart:convert';

class Model {
  int userId;
  int id;
  String title;
  String body;
  bool completed;

  Model({this.userId = 0, this.id = 0, this.title, this.body, this.completed});

  factory Model.fromJson(Map<String, dynamic> map) {
    return Model(
        userId: map['id'], id: map["id"], title: map["title"], body: map["body"], completed: map["completed"]);
  }

  Map<String, dynamic> toJson() {
    return {'userId':userId, "id": id, "title": title, "body": body, "completed": completed};
  }

  @override
  String toString() {
    return 'Model{userId: $userId id: $id, title: $title, body: $body, completed: $completed}';
  }

}

List<Model> ModelFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Model>.from(data.map((item) => Model.fromJson(item)));
}

String ModelToJson(Model data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
