class PostModel {
  int? id;
  String? title;
  PostModel({int? id, String? title}) {
    this.id = id;
    this.title = title;
  }

  factory PostModel.fromjson(Map<String, dynamic> json) {
          int ? id = json["id"];
          String? title = json["title"];
      return PostModel(id: id,title: title);
  }

  // PostModel({this.id, this.title});

  // factory PostModel.fromJson(Map<String, dynamic> json) {
  //   return PostModel(id: json["id"], title: json["title"]);
  // }
}
