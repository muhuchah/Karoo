import 'package:project/component/job_file.dart';

import '../component/user_file.dart';
import 'package:http/http.dart' as http;

class JobRequest{
  static const String _base = "http://192.168.137.1:8000/";
  static const String _jobList = "jobs/list/";

  static Future<List<Job>> getJobsBySubCategory(String subCategory) async {
    User user = User();
    var response = await http.get(
        Uri.parse("$_base$_jobList?SubCategory__title=$subCategory"),
        headers: <String , String>{
          "Authorization": "Bearer ${user.accessToken!}"
        }
    );

    if(response.statusCode == 200){
      return [];
    }

    throw Exception("Unable to send jobs");
  }
}