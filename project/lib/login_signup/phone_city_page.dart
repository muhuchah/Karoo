import 'package:flutter/material.dart';

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
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: Container(
            margin: const EdgeInsets.only(left : 20 , right: 20 ,top: 100),
            child: Column(
              children: [
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
              ],
            ),
          )
        )
      ),
    );
  }
}
