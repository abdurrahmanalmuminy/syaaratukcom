import 'package:flutter/material.dart';

Function progressDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
        child: Container(
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const CircularProgressIndicator(),
        ),
      );
    },
  );

  return () {
    Navigator.pop(context);
  };
}