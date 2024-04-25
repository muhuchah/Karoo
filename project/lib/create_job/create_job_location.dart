import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/my_appbars.dart';

import '../request/user_requests.dart';
import '../widgets/drop_down_button.dart';

class CreateJobLocationPage extends StatefulWidget {
  const CreateJobLocationPage({super.key});

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 20 , left: 20 , top: 50),
            child: Column(
              children: [
                getProvinces(),
                const SizedBox(height: 30,),
                getCities(),
              ],
            ),
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
