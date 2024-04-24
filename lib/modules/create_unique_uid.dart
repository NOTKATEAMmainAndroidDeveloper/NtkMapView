import 'dart:math';

///Simple method for create random Id
///[count] is a length of String
///[isNumberEnabled] if true, created String were contained numbers
String createUniqueUid({int count = 12, bool isNumberEnabled = true}){
  String res = "";
  String alph = isNumberEnabled == true ? "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

  for(var i = 0; i < count; i++){
    res += alph[Random().nextInt(alph.length - 1)];
  }

  return res;
}