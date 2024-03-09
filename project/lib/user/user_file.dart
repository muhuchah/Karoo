class User{
  String? _token;
  String _fullName;
  String _email;
  String _password;
  String _phoneNumber;

  User(this._fullName , this._email , this._password , this._phoneNumber);

  factory User.fromJson(Map<String , dynamic> json){
    return User(json["full_name"], "", "", json["phone_number"]);
  }

  set fullName(String name){
    _fullName = name;
  }

  set email(String email){
    _email = email;
  }

  set phoneNumber(String number){
    _phoneNumber = number;
  }

  set password(String password){
    _password = password;
  }

  set token(String token){
    _password = password;
  }

  String get fullName{return _fullName;}

  String get email{return _email;}

  String get phoneNumber{return _phoneNumber;}

  String get password{return _password;}


}