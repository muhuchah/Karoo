class TimeTableData{
  static String startTime = "";
  static String endTime = "";
  static List<bool> selectedValues = [];
  static Map<String,List<String>> times = {};
  static Function()? onTap;

  static void init(){
    startTime = "";
    endTime = "";

    for(int i=0;i<7;i++){
      selectedValues.add(false);
    }

    List<String> temp = ["Saturday","Sunday","Monday","Tuesday",
      "Wednesday","Thursday","Friday"];
    for(int i=0;i<7;i++){
      times[temp[i]] = [];
    }
  }
}