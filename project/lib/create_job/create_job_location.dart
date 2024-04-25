import 'package:flutter/material.dart';
import 'package:project/create_job/create_job_buttons.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

import '../request/user_requests.dart';
import '../widgets/drop_down_button.dart';
import '../widgets/long_button.dart';

class CreateJobLocationPage extends StatefulWidget {
  Function(String province , String city) onTap;
  CreateJobLocationPage({super.key , required this.onTap});

  @override
  State<CreateJobLocationPage> createState() => _CreateJobLocationPageState();
}

class _CreateJobLocationPageState extends State<CreateJobLocationPage> {
  List<String> province = ["-----"];
  String? selectedProvince = "-----";
  String? selectedCity = "-----";
  @override
  Widget build(BuildContext context) {
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
                  if(selectedProvince == "-----"){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content:  Text("choose a province"),
                        duration: Duration(seconds: 1),)
                    );
                  }
                  else if(selectedCity == "-----"){
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content:  Text("choose a city"),
                          duration: Duration(seconds: 1),)
                    );
                  }
                  else{
                    widget.onTap(selectedProvince! , selectedCity!);
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
    return province.length == 1 ?
    FutureBuilder(future: UserRequest.getProvinces(),
        builder: (context , snapShot){
          if(snapShot.hasData){
            province = snapShot.data!;
            return MyDropButton(items : province , selectedItem: selectedProvince ,
              label : "Province" , rebuild: (value){
                setState(() {
                  selectedProvince = value;
                  selectedCity = "-----";
                });
              },
            );
          }
          else if(snapShot.hasError){
            return MyDropButton(items : province, selectedItem: selectedProvince ,
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
    MyDropButton(items : province , selectedItem: selectedProvince,
        label : "Province" , rebuild: (value){
          setState(() {
            selectedProvince = value;
            selectedCity = "-----";
          });
        }
    );
  }

  Widget getCities(){
    return selectedProvince != "-----" ?
    FutureBuilder(future: UserRequest.getCities(selectedProvince!),
        builder: (context , snapShot){
          if(snapShot.hasData){
            return MyDropButton(items : snapShot.data! , selectedItem: selectedCity ,
              label : "City" , rebuild: (value){
                selectedCity = value;
              },
            );
          }
          else if(snapShot.hasError){
            return MyDropButton(items : const ["-----"], selectedItem: selectedCity ,
              label : "City" , rebuild: (value){},
            );
          }
          else{
            return const CircularProgressIndicator();
          }
        }
    ) :
    MyDropButton(items : const ["-----"] , selectedItem: selectedCity,
        label : "City" , rebuild: (value){
          selectedCity = value;
        }
    );
  }
}
