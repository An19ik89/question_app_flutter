import 'package:flutter/material.dart';

double getProportionateScreenHeight(context,double inputHeight) {
  double screenHeight = MediaQuery.of(context).size.height;
  return (inputHeight / screenHeight) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(context,double inputWidth) {
  double screenWidth = MediaQuery.of(context).size.width;
  return (inputWidth / screenWidth) * screenWidth;
}