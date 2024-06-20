import 'package:flutter/material.dart';
import 'package:project/about/about_page.dart';
import 'package:project/about/contact_page.dart';
import 'package:project/faq/faq_page.dart';
import 'package:project/support/support_page.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';
import 'package:project/my_karoo/my_karoo_list_tile.dart';
import 'package:project/utils/app_color.dart';

import 'my_karoo_list_text.dart';

class MyKarooPage extends StatefulWidget {
  const MyKarooPage({super.key});

  @override
  State<MyKarooPage> createState() => _MyKarooPageState();
}

class _MyKarooPageState extends State<MyKarooPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: MainAppBar(text: "Karoo",actions: [
        IconButton(onPressed: (){
          Navigator.of(context).pushNamed("/wallet");
        }, icon: const Icon(Icons.wallet_outlined),
          style: IconButton.styleFrom(iconSize: 32),
        ),
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.add_alert_rounded),
          style: IconButton.styleFrom(iconSize: 32),
        ),
        IconButton(onPressed: (){

        }, icon: const Icon(Icons.settings),
          style: IconButton.styleFrom(iconSize: 32),
        ),
        const SizedBox(width: 10,)
      ],),
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.background,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyKarooListTile(
                title: "Profile",
                icon: Icons.person_outline,
                onPressed:(){
                  Navigator.of(context).pushNamed("/profile");
                },
              ),
              MyKarooListTile(
                title: "Orders",
                icon: Icons.ad_units_outlined,
                onPressed:(){

                },
              ),
              MyKarooListTile(
                title: "Bookmarks",
                icon: Icons.bookmark_border,
                onPressed:(){

                },
              ),
              MyKarooListTile(
                title: "Chats",
                icon: Icons.chat,
                onPressed:(){

                },
              ),
              const SizedBox(height: 40,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: CustomText(text: "Help", size: 20,
                    textColor: AppColor.text1, weight: FontWeight.w500),
              ),
              const SizedBox(height: 10,),
              const MyDivider(margin: 10,),
              MyKarooListText(text: "Support" , onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return SupportPage();
                }));
              },),
              MyKarooListText(text: "Karoo FAQ" , onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return const KarooFAQ();
                }));
              },),
              MyKarooListText(text: "About Karoo" , onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return const About();
                }));
              },),
              MyKarooListText(text: "Contact us" , onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return const Contact();
                }));
              },),
              const SizedBox(height: 50,),
              const Padding(
                padding: EdgeInsets.only(left: 20 , bottom: 20),
                child: CustomText(text: "Karoo v1.0.0", size: 16,
                    textColor: AppColor.hint, weight: FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }
}
