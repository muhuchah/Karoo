import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';

class MyDropButton extends StatefulWidget {
  List<String> items;
  String? selectedItem;
  String label;
  FocusNode focus;
  void Function(String? value) rebuild;
  MyDropButton({super.key , required this.items , required this.label ,
    required this.rebuild , required this.selectedItem , required this.focus});

  @override
  _MyDropButton createState() => _MyDropButton();
}

class _MyDropButton extends State<MyDropButton> {
  @override
  Widget build(BuildContext context) {
    List<String> y = widget.items;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: CustomText(text: widget.label, size: 16,
              textColor: Colors.black, weight: FontWeight.normal),
        ),
        SizedBox(height: 10,),
        Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: 20,right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: widget.selectedItem,
              isExpanded: true,
              focusNode: widget.focus,
              onChanged: (String? newValue) {
                setState(() {
                  widget.selectedItem = newValue!;
                  widget.rebuild(newValue);
                });
              },
              icon: Icon(Icons.keyboard_arrow_down),
              hint: Text(widget.selectedItem! , style: TextStyle(color: AppColor.hint),),
              items: widget.items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}