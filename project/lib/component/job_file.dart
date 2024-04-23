class Job{
  int? _id;
  String? _title;
  String? _subCategory;
  String? _picture;
  String? _description;
  String? _userEmail;
  String? _address;
  int? _experience;
  double? _initialCost;
  double? _costPerHour;
  double? _rating;
  List<String>? _skills;
  List<String>? _comments;

  Job.infoJson(Map<dynamic , dynamic> json){
    _subCategory = json["Sub_category_title"];
    _description = json["description"];
  }

  Job.listJson(Map<dynamic , dynamic> json){
    _id = json["id"];
    _title = json["title"];
    _picture = json["main_picture_url"];
    _description = json["description"];
    _rating = json["average_rating"];
    _address = "Isfahan , Shahreza";
  }

  set id(int? value) {
    _id = value;
  }

  set description(String? value) {
    _description = value;
  }

  set picture(String? value) {
    _picture = value;
  }

  set subCategory(String? value) {
    _subCategory = value;
  }

  set title(String? value) {
    _title = value;
  }

  set userEmail(String? value) {
    _userEmail = value;
  }

  double? get rating => _rating;

  set rating(double? value) {
    _rating = value;
  }

  String? get address => _address;

  set address(String? value) {
    _address = value;
  }

  int? get experience => _experience;

  set experience(int? value) {
    _experience = value;
  }

  String? get subCategory => _subCategory;

  String? get picture => _picture;

  String? get title => _title;

  String? get description => _description;

  int? get id => _id;

  String? get userEmail => _userEmail;

  double? get initialCost => _initialCost;

  set initialCost(double? value) {
    _initialCost = value;
  }

  double? get costPerHour => _costPerHour;

  set costPerHour(double? value) {
    _costPerHour = value;
  }

  List<String>? get skills => _skills;

  set skills(List<String>? value) {
    _skills = value;
  }

  List<String>? get comments => _comments;

  set comments(List<String>? value) {
    _comments = value;
  }
}