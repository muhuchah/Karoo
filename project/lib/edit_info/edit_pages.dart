import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/request/user_requests.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/long_button.dart';
import 'package:project/widgets/my_appbars.dart';

class EditPages extends StatelessWidget {
  String appBar;
  String text;
  String hint;
  String assetPath;
  String bodyParam;
  Function() onTap;
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  EditPages({super.key , required this.text , required this.hint,
    required this.bodyParam, required this.appBar ,
    required this.assetPath , required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: appBar, leading: (){
        Navigator.of(context).pop();
      }),
      body: Padding(
        padding: const EdgeInsets.only(left: 20 , right: 20 , top: 40),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height-150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: text, size: 16,
                          textColor: Colors.black, weight: FontWeight.normal),
                      const SizedBox(height: 15,),
                      SizedBox(
                        height: 50,
                        child: TextFormField(
                          textAlign: TextAlign.left,
                          textAlignVertical: TextAlignVertical.center,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          focusNode: focus,
                          validator: (value){
                            if(value==null || value.isEmpty){
                              return "Please enter $text";
                            }
                            return null;
                          },
                          controller: controller,
                          decoration: InputDecoration(
                            hintText: hint,
                            hintStyle: const TextStyle(color: AppColor.hint , fontSize: 16),
                              prefixIcon: SizedBox(
                                  width: 50,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: SvgPicture.asset(assetPath,width: 30,height: 30,))),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              focusedErrorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              enabledBorder : const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1)),
                              focusedBorder : const UnderlineInputBorder(
                                  borderSide: BorderSide(color: AppColor.text1))
                          ),
                        ),
                      ),
                    ],
                  ),
                  LongButton(
                    onTap: () async {
                      if(_formKey.currentState!.validate()){
                        try {
                          await UserRequest.changeInfo(bodyParam,controller.text);
                          Navigator.of(context).pop();
                          onTap();
                        }
                        catch(e){
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString()),
                                duration: const Duration(seconds: 2),)
                          );
                        }
                      }
                      else{
                        focus.requestFocus();
                      }
                    },
                    text: "Save"
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
