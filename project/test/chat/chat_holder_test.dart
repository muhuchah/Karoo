import 'package:flutter_test/flutter_test.dart';
import 'package:project/chat/chat_holder.dart';

void main(){
  test("chat holder test", (){
    ChatHolder holder = ChatHolder(true, "This is test", "12:12");

    expect(holder.isMe, true);
    expect(holder.message, "This is test");
    expect(holder.time, "12:12");
  });
}