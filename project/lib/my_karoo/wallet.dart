import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/request/user_requests.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';

class WalletPage extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Wallet", leading: (){
        Navigator.of(context).pop();
      }),
      body: SizedBox(
        height: MediaQuery.of(context).size.height-100,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(text: "Balance", size: 24,
                        textColor: Colors.black, weight: FontWeight.w600),
                    CustomText(text: "0\$", size: 24,
                        textColor: Colors.black, weight: FontWeight.w600)
                  ],
                ),
              ),
              const SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 70,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                    ),
                    const CustomText(text: "\$", size: 24,
                        textColor: Colors.black, weight: FontWeight.w600),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.main,
                        fixedSize: const Size(140, 60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                      child: const CustomText(text: "Deposit", size: 24,
                          textColor: Colors.white, weight: FontWeight.w700),
                    ),
                    ElevatedButton(
                      onPressed: (){

                      },
                      child: const CustomText(text: "Withdraw", size: 24,
                          textColor: Colors.white, weight: FontWeight.w700),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.main,
                          fixedSize: const Size(160, 60),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40,),
              const MyDivider(margin: 10,),
              const SizedBox(height: 40,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CustomText(text: "Shaba Number", size: 20,
                    textColor: Colors.black, weight: FontWeight.w600),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: FutureBuilder(
                  future: UserRequest.getShabaNum(),
                  builder: (context , snapshot){
                    if(snapshot.hasData){
                      return CustomText(text: snapshot.data!, size: 16,
                          textColor: Colors.black, weight: FontWeight.w400);
                    }
                    else if(snapshot.hasError){
                      return CustomText(text: snapshot.error.toString(), size: 16,
                          textColor: Colors.black, weight: FontWeight.w400);
                    }

                    return const CircularProgressIndicator();
                  }
                )
              ),
              const SizedBox(height: 40,),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pushNamed("/edit-shaba");
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                ),
                child: const CustomText(text: "Edit Shaba Number", size: 16,
                    textColor: AppColor.loginText1, weight: FontWeight.w400
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
