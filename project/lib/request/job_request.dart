import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:project/component/image.dart';
import 'package:project/component/job_file.dart';
import 'package:project/component/skill_file.dart';
import 'package:project/create_job/job_data.dart';
import 'package:project/time_table/time_table_data.dart';

import '../component/user_file.dart';

class JobRequest {
  static const String _base = "https://karoo.liara.run/";
  static const String _jobList = "jobs/list/";
  static const String _jobDetail = "jobs/detail/";
  static const String _userJobs = "jobs/user/info/";
  static const String _userPictures = "jobs/user/pictures/";
  static const String _skills = "jobs/skills/";
  static const String _createComment = "jobs/comment/create/";
  static const String _editComment = "jobs/comment/edit/";
  static const String _editTimeTable = "jobs/timetable/";

  static Future<List<Job>> getJobs() async {
    User user = User();
    var response = await http.get(Uri.parse("$_base$_jobList"),
        headers: <String, String>{
          "Authorization": "Bearer ${user.accessToken!}"
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Job> jobs = [];
      for (int i = 0; i < body.length; i++) {
        jobs.add(Job.listJson(body[i]));
      }
      return jobs;
    }

    throw Exception("Unable to get jobs");
  }

  static Future<List<Job>> getJobsBySubCategory(String subCategory) async {
    User user = User();
    var response = await http.get(
        Uri.parse("$_base$_jobList?SubCategory__title=$subCategory"),
        headers: <String, String>{
          "Authorization": "Bearer ${user.accessToken!}"
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Job> jobs = [];
      for (int i = 0; i < body.length; i++) {
        jobs.add(Job.listJson(body[i]));
      }
      return jobs;
    }

    throw Exception("Unable to get jobs");
  }

  static Future<Job> getJobDetail(int id) async {
    User user = User();
    var response = await http.get(Uri.parse("$_base$_jobDetail$id"),
        headers: <String, String>{
          "Authorization": "Bearer ${user.accessToken!}"
        });

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      Job job = Job.infoJson(body);
      TimeTableData.setTimeTable(body["timetable"]);
      return job;
    }

    throw Exception("Unable to load job");
  }

  static Future<List<Job>> getUserJobs() async {
    User user = User();
    var response = await http.get(Uri.parse("$_base$_userJobs"),
        headers: <String, String>{
          "Authorization": "Bearer ${user.accessToken!}"
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Job> jobs = [];
      for (int i = 0; i < body.length; i++) {
        jobs.add(Job.listJson(body[i]));
      }
      return jobs;
    }

    throw Exception("Unable to get jobs");
  }

  static Future<List<Skill>> getSkills() async {
    User user = User();
    var response = await http.get(Uri.parse("$_base$_skills"),
        headers: <String, String>{
          "Authorization": "Bearer ${user.accessToken!}"
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Skill> skills = [];

      for(int i=0;i<body.length;i++){
        skills.add(Skill(id: body[i]["id"], title: body[i]["title"]));
      }

      return skills;
    }

    throw Exception("Unable to load Skills");
  }

  static Map _getJobJson() {
    Map values = {};
    values["title"] = JobData.title;
    values["SubCategory"] = JobData.subCategoryId;
    values["province"] = JobData.province;
    values["city"] = JobData.city;

    if (JobData.description != "") {
      values["description"] = JobData.description;
    }
    if (JobData.experience != "") {
      values["experiences"] = JobData.experience;
    }
    if (JobData.costPerHour != "") {
      values["approximation_cph"] = JobData.costPerHour;
    }
    if (JobData.initialCost != "") {
      values["initial_cost"] = JobData.initialCost;
    }

    List skills = [];
    for (int i = 0; i < JobData.skills.length; i++) {
      skills.add({"title": JobData.skills[i].title});
    }
    values["skills"] = skills;

    return values;
  }

  static Future<Job> createJob() async {
    User user = User();
    var response = await http.post(Uri.parse("$_base$_userJobs"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user.accessToken!}"
        },
        body: jsonEncode(_getJobJson()));

    if (response.statusCode == 201) {
      Job newJob = Job.infoJson(jsonDecode(response.body));
      return newJob;
    }

    throw Exception("Unable to create job");
  }

  static Future<void> createJobPicture(File image, id) async {
    User user = User();
    var request =
        http.MultipartRequest("POST", Uri.parse(_base + _userPictures));
    request.headers["Authorization"] = "Bearer ${user.accessToken!}";
    request.fields["job"] = "$id";
    request.files.add(await http.MultipartFile.fromPath("image", image.path));
    var response = await request.send();

    if (response.statusCode != 201) {
      throw Exception("Unable to create image");
    }
  }

  static Map _getEditBody(Job job) {
    Map values = {};
    if (job.title != JobData.title) {
      values["title"] = JobData.title;
    }
    if (job.subCategory != JobData.subCategory) {
      values["SubCategory"] = JobData.subCategoryId;
    }
    if (job.province != JobData.province) {
      values["province"] = JobData.province;
    }
    if (job.city != JobData.city) {
      values["city"] = JobData.city;
    }
    if (job.description != JobData.description &&
        ((job.description != "" && job.description != null) ||
            JobData.description != "")) {
      values["description"] = JobData.description;
    }
    if (job.experience != JobData.experience &&
        ((job.experience != "" && job.experience != null) ||
            JobData.experience != "")) {
      values["experiences"] = JobData.experience;
    }
    if (job.costPerHour != JobData.costPerHour &&
        ((job.costPerHour != "" && job.costPerHour != null) ||
            JobData.costPerHour != "")) {
      values["approximation_cph"] = JobData.costPerHour;
    }
    if (job.initialCost != JobData.initialCost &&
        ((job.initialCost != "" && job.initialCost != null) ||
            JobData.initialCost != "")) {
      values["initial_cost"] = JobData.initialCost;
    }

    List<Map> skills = [];
    for (int i = 0; i < JobData.skills.length; i++) {
      skills.add({"title": JobData.skills[i].title});
    }
    values["skills"] = skills;

    return values;
  }

  static Future<Job> editJob(Job job) async {
    User user = User();
    var response = await http.put(Uri.parse("$_base$_userJobs${job.id}/"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user.accessToken!}"
        },
        body: jsonEncode(_getEditBody(job)));

    if (response.statusCode == 200) {
      Job newJob = Job.infoJson(jsonDecode(response.body));
      return newJob;
    }
    throw Exception("Unable to update job");
  }

  static Future<void> deleteJobPicture(ImageFile image) async {
    User user = User();
    var response = await http.delete(
      Uri.parse("$_base$_userPictures${image.id}/"),
      headers: <String, String>{"Authorization": "Bearer ${user.accessToken!}"},
    );

    if (response.statusCode != 204) {
      throw Exception("Unable to delete image");
    }
  }

  static Future<void> deleteJob(Job job) async {
    User user = User();
    var response = await http.delete(Uri.parse("$_base$_userJobs${job.id}/"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user.accessToken!}"
        },);

    if (response.statusCode != 204) {
      throw Exception("Unable to update job");
    }
  }

  static Map _getCommentBody(String title , String comment
      , int rating , int jobId){

    Map values = {};
    values["title"] = title;
    values["comment"] = comment;
    values["rating"] = rating;
    values["job"] = jobId;

    return values;
  }

  static Future<void> createComment(String title , String comment
      , int rating , int jobId) async {
    User user = User();
    var response = await http.post(Uri.parse("$_base$_createComment"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user.accessToken!}"
        },
        body: jsonEncode(_getCommentBody(title, comment, rating, jobId)));

    if (response.statusCode != 201) {
      throw Exception("Unable to create comment");
    }
  }

  static Future<void> editComment(String title , String comment
      , int rating , int jobId , int commentId) async {
    User user = User();
    var response = await http.put(Uri.parse("$_base$_editComment$commentId"),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Authorization": "Bearer ${user.accessToken!}"
        },
        body: jsonEncode(_getCommentBody(title, comment, rating, jobId)));

    if (response.statusCode != 200) {
      throw Exception("Unable to change comment");
    }
  }

  static Future<List<Job>> getSearchJobs(String search) async {
    User user = User();
    var response = await http.get(Uri.parse("$_base$_jobList?search=$search"),
        headers: <String, String>{
          "Authorization": "Bearer ${user.accessToken!}"
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Job> jobs = [];
      for (int i = 0; i < body.length; i++) {
        jobs.add(Job.listJson(body[i]));
      }
      return jobs;
    }

    throw Exception("Unable to search jobs");
  }

  static String _getFilterUrl(Map<String , String> filters){
    String url = "";
    for(int i=0;i<filters.keys.length;i++){
      url += "${filters.keys.elementAt(i)}=${filters[filters.keys.elementAt(i)]}";
      if(i!=filters.length-1){
        url += "&";
      }
    }
    return url;
  }

  static Future<List<Job>> getFilterJobs(Map<String , String> filters) async {
    User user = User();
    String url = _getFilterUrl(filters);
    var response = await http.get(Uri.parse("$_base$_jobList?$url"),
        headers: <String, String>{
          "Authorization": "Bearer ${user.accessToken!}"
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Job> jobs = [];
      for (int i = 0; i < body.length; i++) {
        jobs.add(Job.listJson(body[i]));
      }
      return jobs;
    }

    throw Exception("Unable to filter jobs");
  }

  static Future<void> deleteComment(int id) async {
    User user = User();
    var response = await http.delete(Uri.parse("$_base$_editComment$id"),
        headers: <String, String>{
          "Authorization": "Bearer ${user.accessToken!}"
        }
    );

    if (response.statusCode != 204) {
      throw Exception("Unable to delete comment");
    }
  }

  static String _getTimeTableValues(){
    List timeTable = [];
    Map<String,List<String>> times = TimeTableData.times;

    times.forEach((key, value){
      Map temp = {};
      temp["day_of_week"] = key;

      List listTimes = [];

      for(String v in value){
        List<String> timesValue = v.split("-");
        Map tempTime = {
          "start_time" : timesValue[0],
          "end_time" : timesValue[1]
        };

        listTimes.add(tempTime);
      }

      temp["time_slots"] = listTimes;
      timeTable.add(temp);
    });

    Map mapValues = {"timetable" : timeTable};

    return jsonEncode(mapValues);
  }

  static Future<void> setTimeTable(int id) async {
    User user = User();
    var response = await http.post(Uri.parse("$_base$_editTimeTable$id"),
      headers: <String,String>{
        "Content-Type": "application/json",
        "Authorization": "Bearer ${user.accessToken!}"
      },
      body: _getTimeTableValues()
    );

    if (response.statusCode != 200) {
      throw Exception("Unable to create time table");
    }
  }
}
