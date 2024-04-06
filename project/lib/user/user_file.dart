import 'package:flutter/foundation.dart';

class User{
  String? _accessToken;
  String? _refreshToken;
  String? _fullName;
  String? _email;
  String? _address;
  String? _password;
  String? _phoneNumber;

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

  set address(String? address){
    _address = address;
  }

  set password(String? password){
    _password = password;
  }

  set accessToken(String? token){
    _accessToken = token;
  }

  set refreshToken(String? token){
    _refreshToken = token;
  }

  String? get fullName{return _fullName;}

  String? get email{return _email;}

  String? get phoneNumber{return _phoneNumber;}

  String? get address{return _address;}

  String? get password{return _password;}

  String? get accessToken{return _accessToken;}

  String? get refreshToken{return _refreshToken;}

  void setNullPart(){
    _fullName = null;
    _address = null;
    _phoneNumber = null;
    _email = null;
    _password = null;
    _accessToken = null;
    _refreshToken = null;
  }
}