import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/faq/faq_text_icon.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/utils/app_text.dart';
import 'package:project/widgets/my_appbars.dart';

class KarooFAQ extends StatefulWidget {
  const KarooFAQ({super.key});

  @override
  State<KarooFAQ> createState() => _KarooFAQState();
}

class _KarooFAQState extends State<KarooFAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppBar(text: "FAQ", leading: (){
        Navigator.of(context).pop();
      }),
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Column(
          children: getChildren()
        ),
      ),
    );
  }

  List<Widget> getChildren() {
    List<Widget> children = [];

    AppText.faqValues.forEach((key, value){
      children.add(FAQTextIcon(title: key, text: value));
    });

    return children;
  }
}
