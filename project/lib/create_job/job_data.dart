import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:project/component/skill_file.dart';

import '../component/image.dart';
import '../component/job_file.dart';

class JobData{
  static bool isCreate = true;
  static String subCategory = "";
  static int subCategoryId = -1;
  static List<File> images = [];
  static List<ImageFile> readImages = [];
  static String title = "";
  static String description = "";
  static String province = "";
  static String city = "";
  static bool timeTable = false;
  static String experience = "";
  static String initialCost = "";
  static String costPerHour = "";
  static List<Skill> skills = [];
  static Function(Job job ,BuildContext context)? onTap;
  static Job? job;

  static void init(){
    JobData.isCreate = true;
    JobData.job = null;
    JobData.subCategory = "";
    JobData.subCategoryId = -1;
    JobData.images = [];
    JobData.readImages = [];
    JobData.title = "";
    JobData.description = "";
    JobData.province = "";
    JobData.city = "";
    JobData.timeTable = false;
    JobData.experience = "";
    JobData.initialCost = "";
    JobData.costPerHour = "";
    JobData.skills = [];
  }

  static void setEditValues(Job job){
    JobData.isCreate = false;
    JobData.job = job;
    JobData.title = job.title!;
    JobData.subCategory = job.subCategory!;
    _cloneImages(job.pictures!);
    JobData.province = job.province!;
    JobData.city = job.city!;
    _cloneSkills(job.skills!);

    if(job.description !=null && job.description!= ""){
      JobData.description = job.description!;
    }
    if(job.initialCost !=null && job.initialCost!= ""){
      JobData.initialCost = job.initialCost!;
    }
    if(job.experience !=null && job.experience!= ""){
      JobData.experience = job.experience!;
    }
    if(job.costPerHour !=null && job.costPerHour!= ""){
      JobData.costPerHour = job.costPerHour!;
    }
  }

  static void _cloneSkills(List<Skill> skills){
    for(int i = 0;i<skills.length;i++){
      JobData.skills.add(Skill(id: skills[i].id, title: skills[i].title));
    }
  }

  static void _cloneImages(List<ImageFile> images){
    for(int i = 0;i<images.length;i++){
      JobData.readImages.add(ImageFile(id: images[i].id, imageUrl: images[i].imageUrl));
    }
  }
}