import 'package:flutter/material.dart';
import 'package:project/component/user_file.dart';
import 'package:project/request/wallet_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/divider.dart';
import 'package:project/widgets/my_appbars.dart';
import 'package:url_launcher/url_launcher.dart';

class WalletPage extends StatefulWidget {

  WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Wallet", leading: (){
        Navigator.of(context).pop();
      }),
      body: FutureBuilder(
        future: WalletRequest.getWalletInfo(),
        builder: (context,snapShot){
          if(snapShot.hasData){
            return getBody(context);
          }
          else if(snapShot.hasError){
            return SizedBox(
              height: 200,
              child: Center(
                child: CustomText(text: snapShot.error.toString(), size: 20,
                    textColor: Colors.black, weight: FontWeight.normal),
              ),
            );
          }
          else{
            return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(child: CircularProgressIndicator())
            );
          }
        }
      ),
    );
  }

  Widget getBody(context){
    User user = User();

    return SizedBox(
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
                  CustomText(text: "${user.wallet}\$", size: 24,
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
                    onPressed: () async {
                      try{
                        double amount = double.parse(controller.text);
                        if(amount<1000){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Enter number greater than 1000"),
                                duration: Duration(seconds: 2),
                              )
                          );
                        }
                        else{
                          String url = await WalletRequest.pay(amount);
                          if (!await launchUrl(Uri.parse(url))) {
                            throw Exception('Could not launch $url');
                          }
                          else{
                            Navigator.of(context).pop();
                          }
                        }
                      }
                      on FormatException catch (_){
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Enter number"),
                              duration: Duration(seconds: 2),
                            )
                        );
                      }
                      catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString()),
                              duration: const Duration(seconds: 2),
                            )
                        );
                      }
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
                    onPressed: () async {
                      try{
                        await WalletRequest.withdraw(double.parse(controller.text));
                        setState(() {});
                      }
                      on FormatException catch (_){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Enter number"),
                            duration: Duration(seconds: 2),
                          )
                        );
                      }
                      catch(e){
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(e.toString()),
                              duration: const Duration(seconds: 2),
                            )
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.main,
                        fixedSize: const Size(160, 60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    child: const CustomText(text: "Withdraw", size: 24,
                        textColor: Colors.white, weight: FontWeight.w700),
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
              child: CustomText(text: user.shabaNum!, size: 16,
                  textColor: Colors.black, weight: FontWeight.w400)
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
    );
  }
}
