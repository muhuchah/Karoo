import 'package:flutter/material.dart';
import 'package:project/create_job/create_job_buttons.dart';
import 'package:project/create_job/job_data.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

import '../request/user_requests.dart';
import '../widgets/drop_down_button.dart';
import '../widgets/long_button.dart';

class CreateJobLocationPage extends StatefulWidget {
  List<String> province = ["-----"];
  String? selectedProvince = "-----";
  String? selectedCity = "-----";
  bool first = false;
  Function(String province , String city) onTap;
  CreateJobLocationPage({super.key , required this.onTap});

  @override
  State<CreateJobLocationPage> createState() => _CreateJobLocationPageState();
}

class _CreateJobLocationPageState extends State<CreateJobLocationPage> {
  @override
  Widget build(BuildContext context) {
    _checkJobData();
    return Scaffold(
      appBar: SubAppBar(text: "Location", leading: (){
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 70,
        child: Padding(
          padding: const EdgeInsets.only(right: 20 , left: 20 , top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  getProvinces(),
                  const SizedBox(height: 30,),
                  getCities(),
                ],
              ),
              LongButton(
                onTap: (){
                  if(widget.selectedProvince == "-----"){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content:  Text("choose a province"),
                        duration: Duration(seconds: 1),)
                    );
                  }
                  else if(widget.selectedCity == "-----"){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content:  Text("choose a city"),
                          duration: Duration(seconds: 1),)
                    );
                  }
                  else{
                    widget.onTap(widget.selectedProvince! , widget.selectedCity!);
                    Navigator.of(context).pop();
                  }
                },
                text: "Save"
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getProvinces(){
    return widget.province.length == 1 ?
    FutureBuilder(future: UserRequest.getProvinces(),
        builder: (context , snapShot){
          if(snapShot.hasData){
            widget.province = snapShot.data!;
            return MyDropButton(items : widget.province , selectedItem: widget.selectedProvince ,
              label : "Province" , rebuild: (value){
                setState(() {
                  widget.selectedProvince = value;
                  widget.selectedCity = "-----";
                });
              },
            );
          }
          else if(snapShot.hasError){
            return MyDropButton(items : widget.province, selectedItem: widget.selectedProvince ,
              label : "Province" , rebuild: (value){
                setState(() {});
              },
            );
          }
          else{
            return const CircularProgressIndicator();
          }
        }
    ) :
    MyDropButton(items : widget.province , selectedItem: widget.selectedProvince,
        label : "Province" , rebuild: (value){
          setState(() {
            widget.selectedProvince = value;
            widget.selectedCity = "-----";
          });
        }
    );
  }

  void _checkJobData(){
    if(!widget.first) {
      if (JobData.province != "") {
        widget.selectedProvince = JobData.province;
        widget.selectedCity = JobData.city;
      }
      widget.first = true;
    }
  }

  Widget getCities(){
    return widget.selectedProvince != "-----" ?
    FutureBuilder(future: UserRequest.getCities(widget.selectedProvince!),
        builder: (context , snapShot){
          if(snapShot.hasData){
            return MyDropButton(items : snapShot.data! , selectedItem: widget.selectedCity ,
              label : "City" , rebuild: (value){
                widget.selectedCity = value;
              },
            );
          }
          else if(snapShot.hasError){
            return MyDropButton(items : const ["-----"], selectedItem: widget.selectedCity ,
              label : "City" , rebuild: (value){},
            );
          }
          else{
            return const CircularProgressIndicator();
          }
        }
    ) :
    MyDropButton(items : const ["-----"] , selectedItem: widget.selectedCity,
        label : "City" , rebuild: (value){
          widget.selectedCity = value;
        }
    );
  }
}
