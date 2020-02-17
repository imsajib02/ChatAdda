import 'package:flutter/material.dart';

class Debug {

  void printDebug(String tag, String msg) {

    print("Debug: $tag ==> $msg");
  }

  void printError(String tag, String msg) {

    print("Error: $tag ==> $msg");
  }
}