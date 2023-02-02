import 'package:flutter/material.dart';

const String addUserUrl = 'https://pocazuredeploy.azurewebsites.net/addUsers';
const String getUserUrl =
    'https://pocazuredeploy.azurewebsites.net/getALLUsers';

var whiteAndBold =
    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
TextStyle getWhiteBoldStyle(
    {Color? color, FontWeight? fontWeight, double? fontSize}) {
  return TextStyle(
      color: color ?? Colors.black,
      fontWeight: fontWeight ?? FontWeight.bold,
      fontSize: fontSize);
}
