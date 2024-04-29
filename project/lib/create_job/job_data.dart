import 'dart:io';

class JobData{
  static String subCategory = "";
  static List<File> images = [];
  static String title = "";
  static String description = "";
  static String province = "";
  static String city = "";
  static String experience = "";
  static String initialCost = "";
  static String costPerHour = "";
  static List<String> skills = [];
  static Function()? createOnTap;

  static void init(){
    JobData.subCategory = "";
    JobData.images = [];
    JobData.title = "";
    JobData.description = "";
    JobData.province = "";
    JobData.city = "";
    JobData.experience = "";
    JobData.initialCost = "";
    JobData.costPerHour = "";
    JobData.skills = [];
    JobData.createOnTap = null;
  }
}