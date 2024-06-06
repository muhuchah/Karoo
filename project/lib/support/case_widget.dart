import 'package:flutter/material.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';

class CaseWidget extends StatefulWidget {
  bool isClick = false;
  String caseTitle;
  CaseWidget({super.key , required this.caseTitle});

  @override
  State<CaseWidget> createState() => _CaseWidgetState();
}

class _CaseWidgetState extends State<CaseWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: widget.isClick ? _clicked() : _notClicked(),
    );
  }

  Widget _notClicked(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: widget.caseTitle, size: 16,
                  textColor: Colors.black, weight: FontWeight.w600),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: (){
                  setState(() {
                    widget.isClick = true;
                  });
                },
                icon: const Icon(Icons.arrow_forward_ios , size: 24,)
              )
            ],
          ),
        ),
        const SizedBox(height: 10,),
        const MyDivider(margin: 10,)
      ],
    );
  }

  Widget _clicked(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: widget.caseTitle, size: 16,
                    textColor: Colors.black, weight: FontWeight.w600),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: (){
                    setState(() {
                      widget.isClick = false;
                    });
                  },
                  icon: Image.asset("asset/icons/ios-arrow-down.png",width: 24,height: 24,)
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5 , left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _getChildren(),
            ),
          ),
          const MyDivider(),
        ],
      ),
    );
  }

  List<Widget> _getChildren(){
    List<Widget> children = [];
    for(int i=0;i<2;i++){
      children.add(
        TextButton(
          onPressed: (){

          },
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: CustomText(text: "", size: 16,
              textColor: Colors.black, weight: FontWeight.w400),
        )
      );

      children.add(const SizedBox(height: 20,));
    }
    return children;
  }
}
