import 'package:flutter/material.dart';
import 'package:sayaaratukcom/addition/paddings.dart';
import 'package:sayaaratukcom/addition/widgets.dart';
import 'package:uicons/uicons.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: bodyPadding,
          child: Column(
            children: [
              Hero(
                tag: "phone_field",
                child: Material(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      heading(context,
                          title: "تسجيل الدخول",
                          subTitle:
                              "لتسجيل الدخول أو إنشاء حساب، أدخل رقم هاتفك"),
                      textField(
                        context,
                        hint: "رقم الهاتف",
                        icon: UIcons.regularRounded.smartphone,
                        focusNode: _focusNode
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
