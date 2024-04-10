class Category{
  int? _id;
  String? _title;
  String? _description;
  String? _image;

  Category.fromJson(Map<dynamic , dynamic> json){
    _id = json["id"];
    _title = json["title"];
    _description = json["description"];
    _image = json["image"];
  }

  set image(String? value) {
    _image = value;
  }

  set description(String? value) {
    _description = value;
  }

  set title(String? value) {
    _title = value;
  }

  set id(int? value) {
    _id = value;
  }

  String? get image => _image;

  String? get description => _description;

  String? get title => _title;

  int? get id => _id;
}