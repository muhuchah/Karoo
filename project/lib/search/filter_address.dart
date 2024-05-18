import 'package:flutter/material.dart';
import 'package:project/request/job_request.dart';
import 'package:project/search/search.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/long_button.dart';
import 'package:project/widgets/my_appbars.dart';

import '../request/user_requests.dart';
import '../widgets/drop_down_button.dart';

class FilterAddressPage extends StatefulWidget {
  FilterAddressPage({super.key});

  @override
  State<FilterAddressPage> createState() => _FilterAddressPage();
}

class _FilterAddressPage extends State<FilterAddressPage> {
  List<String> province = ["-----"];
  String? selectedProvince = "-----";
  String? selectedCity = "-----";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Edit Address", leading: (){
        Navigator.of(context).pop();
      }),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 120,
          child: Padding(
            padding: const EdgeInsets.only(left: 20 , right: 20 , top: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    getProvinces(),
                    const SizedBox(height: 20,),
                    getCities()
                  ],
                ),
                LongButton(
                  text: "Save",
                  onTap: () {
                    if(selectedProvince == "-----"){
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("choose a province"),
                            duration: Duration(seconds: 2),)
                      );
                    }
                    else if(selectedCity == "-----"){
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("choose a city"),
                            duration: Duration(seconds: 2),)
                      );
                    }
                    else{
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return SearchPage(search: "" , filterTypes: {
                          "user__addresses__city" : selectedCity!
                        },);
                      }));
                    }
                  },
                )
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
