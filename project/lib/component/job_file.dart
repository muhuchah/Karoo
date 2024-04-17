class Job{
  int? _id;
  String? _title;
  int? _subCategoryId;
  String? _subCategory;
  String? _picture;
  String? _description;

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

  int? get subCategoryId => _subCategoryId;

  String? get subCategory => _subCategory;

  String? get picture => _picture;

  String? get title => _title;

  String? get description => _description;

  int? get id => _id;
}