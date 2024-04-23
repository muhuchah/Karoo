import 'dart:math';

import 'package:project/component/comment_file.dart';

class Job{
  int? _id;
  String? _title;
  String? _mainCategory;
  String? _subCategory;
  String? _picture;
  String? _description;
  String? _userEmail;
  String? _address;
  String? _experience;
  String? _initialCost;
  String? _costPerHour;
  double? _rating;
  List<String>? _skills;
  List<Comment>? _comments;

  Job.infoJson(Map<dynamic , dynamic> json){
    _id = json["id"];
    _title = json["title"];
    _picture = json["main_picture_url"];
    _description = json["description"];
    _rating = json["average_rating"];
    _address = "Isfahan , Shahreza";
    // _comments = json["comments"];
    // _skills = json["skills"];
    _experience = json["experiences"];
    _costPerHour = json["approximation_cph"];
    _initialCost = json["initial_cost"];
    _address = "${json["province_name"]} , ${json["city_name"]}";
    _mainCategory = json["Main_category_title"];
    _subCategory = json["Sub_category_title"];
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

  String? get mainCategory => _mainCategory;

  set mainCategory(String? value) {
    _mainCategory = value;
  }

  String? get experience => _experience;

  set experience(String? value) {
    _experience = value;
  }

  String? get subCategory => _subCategory;

  String? get picture => _picture;

  String? get title => _title;

  String? get description => _description;

  int? get id => _id;

  String? get userEmail => _userEmail;

  String? get initialCost => _initialCost;

  set initialCost(String? value) {
    _initialCost = value;
  }

  String? get costPerHour => _costPerHour;

  set costPerHour(String? value) {
    _costPerHour = value;
  }

  List<String>? get skills => _skills;

  set skills(List<String>? value) {
    _skills = value;
  }

  List<Comment>? get comments => _comments;

  set comments(List<Comment>? value) {
    _comments = value;
  }
}