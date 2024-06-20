import 'package:flutter/material.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';

class FAQTextIcon extends StatefulWidget {
  String title;
  String text;
  bool isClick = false;
  FAQTextIcon({super.key, required this.text, required this.title});

  @override
  State<FAQTextIcon> createState() => _FAQTextIconState();
}

class _FAQTextIconState extends State<FAQTextIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: getChildren()
    );
  }
  
  List<Widget> getChildren(){
    List<Widget> children = [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: CustomText(text: widget.title, size: 20,
                  textColor: Colors.black, weight: FontWeight.w600),
            ),
            const Spacer(),
            GestureDetector(
              child: widget.isClick ? Image.asset("asset/icons/ios-arrow-down.png", width: 25,height: 25,):
                const Icon(Icons.arrow_forward_ios, size: 25,),
              onTap: (){
                setState(() {
                  if(widget.isClick){
                    widget.isClick = false;
                  }
                  else{
                    widget.isClick = true;
                  }
                });
              },
            )
          ],
        ),
      )
    ];
    
    if(widget.isClick){
      children.add(Padding(
        padding: const EdgeInsets.only(left: 40, right: 20, bottom: 20),
        child: CustomText(text: widget.text, size: 16,
            textColor: Colors.black, weight: FontWeight.w400),
      ));
    }

    children.add(const MyDivider());
    
    return children;
  }
}
