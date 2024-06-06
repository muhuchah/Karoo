import 'package:flutter/material.dart';
import 'package:project/support/case_widget.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';

class SupportPage extends StatefulWidget {
  List<bool> isClickValues = [];
  SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: "Support", leading: (){
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.background,
      body: SizedBox(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.bottom - 70,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 20 , left: 20),
                child: CustomText(text: "In what cases do you need support?", size: 16,
                    textColor: Colors.black, weight: FontWeight.w400),
              ),
              const SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    for(int i=0;i<3;i++){
      widget.isClickValues.add(false);
    }
  }
}
