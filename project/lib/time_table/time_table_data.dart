class TimeTableData{
  static List<bool> selectedValues = [];
  static Map<String,List<String>> times = {};
  static Function()? onTap;

  static void init(){
    for(int i=0;i<7;i++){
      selectedValues.add(false);
    }

    List<String> temp = ["Saturday","Sunday","Monday","Tuesday",
      "Wednesday","Thursday","Friday"];
    for(int i=0;i<7;i++){
      times[temp[i]] = [];
    }

    times[temp[0]]!.add("6:00-12:00");
    times[temp[0]]!.add("13:00-15:00");
    times[temp[0]]!.add("18:00-18:30");
  }
}