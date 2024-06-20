import 'package:flutter/material.dart';
import 'package:project/first/first_page_button.dart';
import 'package:project/request/wallet_request.dart';
import 'package:project/utils/app_color.dart';
import 'package:project/widgets/custom_text.dart';
import 'package:project/widgets/my_appbars.dart';

class EditShabaNumber extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  FocusNode focus = FocusNode();
  EditShabaNumber({super.key});

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: SubAppBar(text: "Shaba Number", leading: (){
        Navigator.of(context).pop();
      }),
      body: SizedBox(
        height: MediaQuery.of(context).size.height-70-padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: "Shaba Number", size: 20,
                      textColor: Colors.black, weight: FontWeight.w600),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: controller,
                    focusNode: focus,
                    decoration: const InputDecoration(
                      prefixIcon: SizedBox(
                        width: 0,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(text: "IR", size: 16,
                              textColor: Colors.black, weight: FontWeight.w400),
                        ),
                      ),
                      border: UnderlineInputBorder(),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: FirstPageButton(text: "Save", color: AppColor.main, onTap: () async {
                try {
                  var request = await WalletRequest.addShabaNum(controller.text);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/wallet");
                }
                catch(e){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString()),
                      duration: const Duration(seconds: 2),)
                  );
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}
