import 'package:flutter/material.dart';
import 'package:project/chat/chat_holder.dart';
import 'package:project/request/support_request.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:intl/intl.dart';

import '../utils/app_color.dart';

class SupportChatPage extends StatefulWidget {
  List<ChatHolder> messages;
  TextEditingController messageController = TextEditingController();
  bool isEmpty = true;
  FocusNode focusNode = FocusNode();
  SupportChatPage({super.key, required this.messages});

  @override
  State<SupportChatPage> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {

  @override
  void initState() {
    super.initState();
    setListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background,
        body: SizedBox(
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - 70,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              verticalDirection: VerticalDirection.up,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20 , right: 10),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: widget.messageController,
                              minLines: 1,
                              maxLines: 4,
                              focusNode: widget.focusNode,
                              decoration: const InputDecoration(
                                  hintText: "Issue" ,
                                  hintStyle: TextStyle(color: AppColor.hint),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          widget.isEmpty ? IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: (){

                              },
                              icon: const Icon(Icons.attach_file_outlined , size: 24,)
                          ) : IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                var message = widget.messageController.text;
                                try {
                                  DateTime now = DateTime.now();
                                  String formattedDate = DateFormat("kk:mm")
                                      .format(now);
                                  widget.messages.add(ChatHolder(true,
                                      widget.messageController.text,
                                      formattedDate));
                                  widget.messageController.text = "";
                                  widget.focusNode.requestFocus();

                                  await SupportRequest.sendSupportMessage(message);
                                }
                                catch(e){
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(e.toString()),
                                        duration: const Duration(seconds: 2),
                                      )
                                  );
                                }

                                setState(() {});
                              },
                              icon: const Icon(Icons.send , size: 24, color: AppColor.loginText1,)
                          )
                        ],
                      )
                  ),
                ),
                const MyDivider(),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.messages.length,
                    itemBuilder: (context , index){
                      return Padding(
                        padding: const EdgeInsets.only(left: 20 , right: 20 , top: 10 , bottom: 10),
                        child: Align(
                          alignment: widget.messages[index].isMe
                              ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 300),
                            decoration: BoxDecoration(
                                color: widget.messages[index].isMe ? AppColor.loginText1 : Colors.white,
                                borderRadius: BorderRadius.circular(12)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Stack(
                                children: [
                                  Positioned(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(text: widget.messages[index].message, size: 14,
                                            textColor: Colors.black, weight: FontWeight.w400),
                                        const SizedBox(width: 40,),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child:CustomText(text: widget.messages[index].time, size: 10,
                                        textColor: Colors.black, weight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ],
            ),
          ),
        )
    );
  }

  void setListener(){
    widget.messageController.addListener(() {
      if(widget.isEmpty && widget.messageController.text.isNotEmpty){
        setState(() {
          widget.isEmpty = false;
        });
      }
      else if(!widget.isEmpty && widget.messageController.text.isEmpty){
        setState(() {
          widget.isEmpty = true;
        });
      }
    });
  }
}
