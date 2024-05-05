import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:project/component/image.dart';
import 'package:project/component/job_file.dart';
import 'package:project/component/skill_file.dart';
import 'package:project/create_job/job_data.dart';

import '../component/user_file.dart';

class JobRequest {
  static const String _base = "https://karoo.liara.run/";
  static const String _jobList = "jobs/list/";
  static const String _jobDetail = "jobs/detail/";
  static const String _userJobs = "jobs/user/info/";
  static const String _userPictures = "jobs/user/pictures/";

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
      Job job = Job.infoJson(jsonDecode(response.body));
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
    var response = await http.get(Uri.parse("$_base$_userJobs"),
        headers: <String, String>{
          "Authorization": "Bearer ${user.accessToken!}"
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Skill> skills = [
        Skill(id: 1, title: "Plumber Skill 1"),
        Skill(id: 2, title: "Plumber Skill 2"),
        Skill(id: 3, title: "Plumber Skill 3")
      ];
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

    // List<Map> skills = [];
    // for (int i = 0; i < JobData.skills.length; i++) {
    //   skills.add({"title": JobData.skills[i].title});
    // }
    // values["skills"] = skills;

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
}
