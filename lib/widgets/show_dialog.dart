import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, {title, content, onOk}) {
  Widget okButton = TextButton(
    onPressed: onOk ?? (){
      Navigator.pop(context);
    },
    child: const Text("موافق", style: TextStyle(color: Colors.black)),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          okButton,
        ],
      );
    },
  );
}
