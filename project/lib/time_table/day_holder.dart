import 'package:flutter/material.dart';
import 'package:project/time_table/time_picker_holder.dart';
import 'package:project/time_table/time_table_data.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';

class DayHolderWidget extends StatefulWidget {
  int index;
  String text;
  DayHolderWidget({super.key , required this.index , required this.text});

  @override
  State<DayHolderWidget> createState() => _DayHolderWidgetState();
}

class _DayHolderWidgetState extends State<DayHolderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: getChildren(context),
      ),
    );
  }

  Widget addButton(){
    return TextButton(
      onPressed: () async {
        TimeTableData.startTime = "";
        TimeTableData.endTime = "";

        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return TimePickerHolder(
            onTap: (){
              setState(() {});
            },
            day: widget.text,);
        }));
      },
      style: TextButton.styleFrom(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      ),
      child: const CustomText(text: "Add Time", size: 16,
          textColor: AppColor.hint, weight: FontWeight.w400),
    );
  }

  List<Widget> getChildren(context){
    List<Widget> children = [textChild(),const SizedBox(height: 20,)];
    List<String>? times = TimeTableData.times[widget.text];

    List<Widget> rowChildren = [];
    double width = MediaQuery.of(context).size.width*0.5;

    for(int i=0;i<times!.length;i++){
      if(i%2 == 0){
        rowChildren.add(SizedBox(
          width: width,
          child: CustomText(text: times[i], size: 16,
              textColor: Colors.black, weight: FontWeight.w400),
        ));
      }
      else{
        rowChildren.add(CustomText(text: times[i], size: 16,
            textColor: Colors.black, weight: FontWeight.w400),);
        children.add(Row(
          children: rowChildren,
        ));
        children.add(
          const SizedBox(height: 20,)
        );
        rowChildren = [];
      }
    }

    if (times.length % 2 == 0) {
      if(TimeTableData.isCreate) {
        children.add(
            addButton()
        );
      }
    }
    else {
      if(TimeTableData.isCreate) {
        rowChildren.add(
            addButton()
        );
      }
      children.add(Row(
        children: rowChildren,
      ));
      rowChildren = [];
    }

    children.add(const SizedBox(height: 20,));
    children.add(const MyDivider());

    return children;
  }

  Widget textChild(){
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: TimeTableData.selectedValues[widget.index],
            onChanged: (value){
              setState(() {
                if(TimeTableData.selectedValues[widget.index] == true){
                  TimeTableData.selectedValues[widget.index] = false;
                }
                else{
                  TimeTableData.selectedValues[widget.index] = true;
                }
              });
            }
          ),
        ),
        const SizedBox(width: 8,),
        CustomText(text: widget.text, size: 20,
            textColor: TimeTableData.selectedValues[widget.index] ? AppColor.loginText1 :
            Colors.black, weight: FontWeight.w600)
      ],
    );
  }
}
