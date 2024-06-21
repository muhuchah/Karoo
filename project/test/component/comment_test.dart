import 'package:flutter_test/flutter_test.dart';
import 'package:project/component/comment_file.dart';

void main(){
  test("comment testing", (){
    Comment comment = Comment(id: 1, comment: "good job", title: "Good",
      date: "10 years ago", rating: 2, userEmail: "abc@gmail.com", userFullName: "Hamid"
    );

    expect(comment.id, 1);
    expect(comment.comment, "good job");
    expect(comment.title, "Good");
    expect(comment.date, "10 years ago");
    expect(comment.rating, 2);
    expect(comment.userEmail, "abc@gmail.com");
    expect(comment.userFullName, "Hamid");
  });
}