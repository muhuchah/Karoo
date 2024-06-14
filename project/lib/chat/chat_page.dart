import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/chat/chat_holder.dart';
import 'package:project/request/support_request.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:intl/intl.dart';

import '../utils/app_color.dart';

class ChatPage extends StatefulWidget {
  String name;
  String email;
  List<ChatHolder> messages;
  TextEditingController messageController = TextEditingController();
  bool isEmpty = true;
  FocusNode focusNode = FocusNode();
  ChatPage({super.key, required this.name , required this.email
    , required this.messages});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    super.initState();
    setListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.background,
        title: Text(widget.name,overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 20 ,
          fontWeight: FontWeight.w600, color: Colors.black),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
            onPressed:(){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios , size: 28,)),
        ),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: Icon(Icons.more_vert,size: 24,)
          )
        ],
        toolbarHeight: 70,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1,color: AppColor.divider,),
        ),
      ),
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
                            focusNode: widget.focusNode,
                            decoration: const InputDecoration(
                                hintText: "Message" ,
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

                                await SupportRequest.sendMessage(
                                   message , widget.email);
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
              MyDivider(),
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
  
  Widget getBody(List<ChatHolder> messages){
    return SizedBox(
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
                              hintText: "Message" ,
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
                            try {
                              DateTime now = DateTime.now();
                              String formattedDate = DateFormat("kk:mm")
                                  .format(now);
                              messages.add(ChatHolder(true,
                                  widget.messageController.text,
                                  formattedDate));
                              widget.messageController.text = "";
                              widget.focusNode.requestFocus();

                              await SupportRequest.sendMessage(
                                  widget.messageController.text, widget.email);
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
            MyDivider(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: messages.length,
                itemBuilder: (context , index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 20 , right: 20 , top: 10 , bottom: 10),
                    child: Align(
                      alignment: messages[index].isMe
                          ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 300),
                        decoration: BoxDecoration(
                            color: messages[index].isMe ? AppColor.loginText1 : Colors.white,
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
                                    CustomText(text: messages[index].message, size: 14,
                                        textColor: Colors.black, weight: FontWeight.w400),
                                    const SizedBox(width: 40,),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child:CustomText(text: messages[index].time, size: 10,
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
