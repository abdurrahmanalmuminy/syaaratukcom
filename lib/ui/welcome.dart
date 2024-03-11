import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sayaaratukcom/addition/colors.dart';
import 'package:sayaaratukcom/addition/padding.dart';
import 'package:sayaaratukcom/addition/widgets.dart';
import 'package:sayaaratukcom/ui/auth/phone.dart';
import 'package:uicons/uicons.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: SafeArea(
                      bottom: false,
                      child:
                          Image.asset("assets/images/logo.png", width: 150)))),
          Container(
            padding: bodyPadding,
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          textField(context,
                              hint: "رقم الهاتف (..55)",
                              icon: UIcons.regularRounded.smartphone,
                              readOnly: true, onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      const Phone(),
                                  fullscreenDialog: true),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  gap(height: 15),
                  optionB(context,
                      text: "بتسجيل الدخول إلى حسابك أو إنشاء حساب جديد، فأنت توافق على ",
                      option: "سياسة الإستخدام و سياسة الخصوصية")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
