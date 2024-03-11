import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sayaaratukcom/addition/colors.dart';
import 'package:sayaaratukcom/addition/padding.dart';
import 'package:sayaaratukcom/addition/widgets.dart';
import 'package:sayaaratukcom/ui/auth/account.dart';
import 'package:uicons/uicons.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController otp = TextEditingController();
  bool active = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.highlight2),
        borderRadius: BorderRadius.circular(15),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.black),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration:
          defaultPinTheme.decoration?.copyWith(color: AppColors.highlight3),
    );

    void updateButton() {
      setState(() {
        active = otp.text.isNotEmpty ? true : false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(UIcons.regularRounded.angle_right)),
      ),
      body: SafeArea(
        child: Padding(
          padding: bodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heading(context,
                  title: "رمز التحقق",
                  subTitle: "أدخل رمز التحقق المرسل إلى هاتفك"),
              Pinput(
                controller: otp,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                autofocus: true,
                // validator: (s) {
                //   return s == '222222' ? null : "الرمز غير صحيح";
                // },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  updateButton();
                },
              ),
              const Expanded(child: SizedBox()),
              primaryButton(context, "التالي",
                  onPressed: !active
                      ? null
                      : () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => const Account()));
                        }),
              optionB(context,
                  text:
                      "بياناتك آمنة، ولن يتم مشاركتها مع أي طرف ثالث لمزيد من التفاصيل ",
                  option: "سياسة الإستخدام و سياسة الخصوصية")
            ],
          ),
        ),
      ),
    );
  }
}
