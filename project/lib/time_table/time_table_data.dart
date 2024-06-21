import 'package:project/create_job/job_data.dart';

class TimeTableData{
  static String startTime = "";
  static String endTime = "";
  static List<bool> selectedValues = [];
  static Map<String,List<String>> times = {};
  static Function()? onTap;
  static bool isCreate = true;

  static void init(){
    startTime = "";
    endTime = "";
    isCreate = true;

    for(int i=0;i<7;i++){
      selectedValues.add(false);
    }

    List<String> temp = ["Saturday","Sunday","Monday","Tuesday",
      "Wednesday","Thursday","Friday"];
    for(int i=0;i<7;i++){
      times[temp[i]] = [];
    }
  }

  static void setTimeTable(dynamic timeTable){
    init();
    if(timeTable!=null){
      JobData.timeTable = true;
      for(int i=0;i<timeTable.length;i++){
        for(int j=0;j<timeTable[i]["time_slots"].length;j++){
          if(timeTable[i]["time_slots"][j]["start_time"]!=null){
            String start = timeTable[i]["time_slots"][j]["start_time"];
            String end = timeTable[i]["time_slots"][j]["end_time"];

            times[timeTable[i]["day_of_week"]]!.add("$start-$end");
          }
        }
      }
    }
  }
}