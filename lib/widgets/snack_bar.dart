import 'package:flutter/material.dart';

ScaffoldFeatureController snackBar(context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.black,
        content: Text(message, style: const TextStyle(color: Colors.white))),
  );
}