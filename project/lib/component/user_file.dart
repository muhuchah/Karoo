class User{
  String? _accessToken;
  String? _refreshToken;
  String? _fullName;
  String? _email;
  String? _province;
  String? _city;
  int? _addressId;
  String? _phoneNumber;
  String? _shabaNum;
  double? _wallet;

  static final User _user = User._internal();

  factory User(){
    return _user;
  }

  User._internal();

  set fullName(String? name){
    _fullName = name;
  }

  set email(String? email){
    _email = email;
  }

  set phoneNumber(String? number){
    _phoneNumber = number;
  }

  set province(String? province){
    _province = province;
  }

  set city(String? city){
    _city = city;
  }

  set accessToken(String? token){
    _accessToken = token;
  }

  set refreshToken(String? token){
    _refreshToken = token;
  }

  set addressId(int? value) {
    _addressId = value;
  }

  String? get shabaNum => _shabaNum;

  set shabaNum(String? value) {
    _shabaNum = value;
  }

  int? get addressId => _addressId;

  String? get fullName{return _fullName;}

  String? get email{return _email;}

  String? get phoneNumber{return _phoneNumber;}

  String? get province{return _province;}

  String? get city{return _city;}

  String? get accessToken{return _accessToken;}

  String? get refreshToken{return _refreshToken;}

  void setNullPart(){
    _fullName = null;
    _province = null;
    _city = null;
    _addressId = null;
    _phoneNumber = null;
    _email = null;
    _accessToken = null;
    _refreshToken = null;
  }

  double? get wallet => _wallet;

  set wallet(double? value) {
    _wallet = value;
  }
}