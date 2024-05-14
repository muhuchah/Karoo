import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/long_button.dart';
import 'package:project/widgets/my_appbars.dart';

import '../request/user_requests.dart';
import '../widgets/drop_down_button.dart';

class EditAddressPage extends StatefulWidget {
  Function() onTap;
  EditAddressPage({super.key , required this.onTap});

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
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
                  onTap: () async {
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
                      try {
                        await UserRequest.editAddress(
                            selectedProvince!, selectedCity!);
                        Navigator.of(context).pop();
                        widget.onTap();
                      }
                      catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString()),
                              duration: const Duration(seconds: 2),)
                        );
                      }
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
