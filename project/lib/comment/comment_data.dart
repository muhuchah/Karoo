class CommentData{
  static int id = 0;
  static int rating = 0;
  static String title = "";
  static String comment = "";
  static Function()? onSubmitTap;

  static void init(){
    CommentData.id = 0 ;
    CommentData.rating = 0;
    CommentData.title = "";
    CommentData.comment = "";
  }
}