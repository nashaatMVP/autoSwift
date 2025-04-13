import 'package:flutter/material.dart';

import 'custom_text.dart';

class Snack {

  void success (context , msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: CustomText(text: msg),
        backgroundColor: Colors.blueGrey,
    ));
  }


  void error (context , msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: CustomText(text: msg),
      backgroundColor: Colors.red.shade300,
    ));
  }


}
