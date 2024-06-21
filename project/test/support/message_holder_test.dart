import 'package:flutter_test/flutter_test.dart';
import 'package:project/support/message_holder.dart';

void main(){
  test("message holder testing", (){
    SupportMessage message = SupportMessage("some topic", "Issue", "answer");

    expect(message.topic, "some topic");
    expect(message.message, "Issue");
    expect(message.reply, "answer");
  });
}