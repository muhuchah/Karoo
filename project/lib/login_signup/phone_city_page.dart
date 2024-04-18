import 'package:flutter/material.dart';
import 'package:project/login_signup/drop_down_button.dart';
import 'package:project/request/user_requests.dart';
import 'package:project/widgets/long_button.dart';

import '../utils/app_color.dart';
import '../widgets/big_text.dart';
import '../widgets/divider.dart';
import '../widgets/text_icon_widget.dart';

class PhoneCityPage extends StatefulWidget {
  const PhoneCityPage({super.key});

  @override
  State<PhoneCityPage> createState() => _PhoneCityPageState();
}

class _PhoneCityPageState extends State<PhoneCityPage> {
  TextEditingController? phoneController = TextEditingController();
  FocusNode phoneFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();


  List<String> province = ["-----"];
  String? selectedProvince = "-----";
  String? selectedCity = "-----";

  @override
  void dispose() {
    super.dispose();

    phoneController?.dispose();
    phoneFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: AppColor.background,
        title: const BigText(text: "Completing profile"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: MyDivider(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
            child: Container(
              margin: const EdgeInsets.only(left : 20 , right: 20 ,top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(children: [
                      TextIcon(
                        labelText: "PHONE",
                        assetPath: "asset/icons/phone.svg",
                        controller: phoneController,
                        validatorFunction: (value){
                          if(value==null || value.isEmpty){
                            return "Please enter email";
                          }
                          return null;
                        },
                        focus: phoneFocus,
                      ),
                      const SizedBox(height: 60,),
                      getProvinces(),
                      const SizedBox(height: 20,),
                      getCities(),
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35.0),
                    child: LongButton(onTap: () async {
                      if(!_formKey.currentState!.validate()){
                        if(phoneController?.text==null || phoneController?.text==""){
                          phoneFocus.requestFocus();
                        }
                      }
                      else if(selectedProvince=="-----"){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("choose a province"),
                              duration: Duration(seconds: 2),)
                        );
                      }
                      else if(selectedCity=="-----"){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("choose a city"),
                              duration: Duration(seconds: 2),)
                        );
                      }
                      else{
                        try{
                          await UserRequest.changeInfo("phone_number",
                              phoneController!.text);
                          // await UserRequest.setAddress(selectedProvince!,
                          //     selectedCity! );

                          Navigator.of(context).pushReplacementNamed("/home");
                        }
                        catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString()),
                                duration: Duration(seconds: 2),)
                          );
                        }
                      }
                    },text: "Next",),
                  )
                ],
              ),
            )
          )
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
              label : "Cities" , rebuild: (value){
                selectedCity = value;
              },
            );
          }
          else if(snapShot.hasError){
            return MyDropButton(items : const ["-----"], selectedItem: selectedCity ,
              label : "Province" , rebuild: (value){},
            );
          }
          else{
            return const CircularProgressIndicator();
          }
        }
    ) :
    MyDropButton(items : const ["-----"] , selectedItem: selectedCity,
        label : "Cities" , rebuild: (value){
          selectedCity = value;
        }
    );
  }
}
