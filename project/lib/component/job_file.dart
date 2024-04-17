class Job{
  int? _id;
  String? _title;
  int? _subCategoryId;
  String? _subCategory;
  String? _picture;
  String? _description;
  String? _userFullName;
  String? _userAddress;
  String? _userEmail;
  String? _userPicture;

  Job.infoJson(Map<dynamic , dynamic> json){
    _subCategoryId = json["SubCategory"];
    _subCategory = json["Sub_category_title"];
    _description = json["description"];
  }

  Job.listJson(Map<dynamic , dynamic> json){
    _id = json["id"];
    _title = json["title"];
    _picture = json["main_picture_url"];
    _userFullName = json["user_full_name"];
    _userAddress = json["user_addresses_city"];
    _description = json["description"];
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

  set subCategoryId(int? value) {
    _subCategoryId = value;
  }

  set title(String? value) {
    _title = value;
  }

  set userFullName(String? value) {
    _userFullName = value;
  }

  set userEmail(String? value) {
    _userEmail = value;
  }

  set userPicture(String? value) {
    _userPicture = value;
  }

  set userAddress(String? value) {
    _userAddress = value;
  }

  int? get subCategoryId => _subCategoryId;

  String? get subCategory => _subCategory;

  String? get picture => _picture;

  String? get title => _title;

  String? get description => _description;

  int? get id => _id;

  String? get userPicture => _userPicture;

  String? get userEmail => _userEmail;

  String? get userFullName => _userFullName;

  String? get userAddress => _userAddress;
}