import 'dart:math';

import 'package:project/component/comment_file.dart';
import 'package:project/component/skill_file.dart';

class Job{
  int? _id;
  String? _title;
  String? _mainCategory;
  String? _subCategory;
  String? _mainPicture;
  List<String>? _pictures = [];
  String? _description;
  String? _userEmail;
  String? _province;
  String? _city;
  String? _experience;
  String? _initialCost;
  String? _costPerHour;
  double? _rating;
  List<Skill>? _skills = [];
  List<Comment>? _comments = [];

  Job.infoJson(Map<dynamic , dynamic> json){
    _id = json["id"];
    _title = json["title"];
    _mainPicture = json["main_picture_url"];
    _setPictures(json);
    _description = json["description"];
    _rating = json["average_rating"];
    _province = json["province_name"];
    _city = json["city_name"];
    _setComments(json);
    _setSkills(json);
    _experience = json["experiences"];
    _costPerHour = json["approximation_cph"];
    _initialCost = json["initial_cost"];
    _mainCategory = json["Main_category_title"];
    _subCategory = json["Sub_category_title"];
  }

  Job.listJson(Map<dynamic , dynamic> json){
    _id = json["id"];
    _title = json["title"];
    _mainPicture = json["main_picture_url"];
    _description = json["description"];
    _rating = json["average_rating"];
    _province = json["province_name"];
    _city = json["city_name"];
  }

  void _setPictures(Map<dynamic , dynamic> json){
    var pictures = json["pictures"];
    for(int i = 0;i<pictures.length;i++){
      _pictures!.add(pictures[i]["image"]);
    }
  }

  void _setComments(Map<dynamic , dynamic> json){
    var comments = json["comments"];
    for(int i=0;i<comments.length;i++){
      _comments!.add(Comment(comments[i]["id"],comments[i]["comment"],comments[i]["title"]));
    }
  }

  void _setSkills(Map<dynamic , dynamic> json){
    var skills = json["skills"];
    for(int i=0;i<skills.length;i++){
      _skills!.add(Skill(id: skills[i]["id"], title: skills[i]["title"]));
    }
  }

  set id(int? value) {
    _id = value;
  }

  set description(String? value) {
    _description = value;
  }

  set picture(String? value) {
    _mainPicture = value;
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

  String? get mainPicture => _mainPicture;

  set mainPicture(String? value) {
    _mainPicture = value;
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

  String? get picture => _mainPicture;

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

  List<Skill>? get skills => _skills;

  set skills(List<Skill>? value) {
    _skills = value;
  }

  List<Comment>? get comments => _comments;

  set comments(List<Comment>? value) {
    _comments = value;
  }

  List<String>? get pictures => _pictures;

  set pictures(List<String>? value) {
    _pictures = value;
  }

  String? get province => _province;

  set province(String? value) {
    _province = value;
  }

  String? get city => _city;

  set city(String? value) {
    _city = value;
  }
}