import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sayaaratukcom/services/auth_service.dart';
import 'package:sayaaratukcom/styles/colors.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/utils/launch_url.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class Verification extends StatefulWidget {
  final String verificationId;
  const Verification({super.key, required this.verificationId});

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController smsCode = TextEditingController();
  bool active = false;
  bool _loading = false;

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
        active = smsCode.text.isNotEmpty ? true : false;
      });
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(UIcons.regularRounded.angle_right)),
      ),
      body: SafeArea(
        child: Padding(
          padding: Dimensions.bodyPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heading(context,
                  title: "رمز التحقق",
                  subTitle: "أدخل رمز التحقق المرسل إلى هاتفك"),
              Pinput(
                controller: smsCode,
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
                  loading: _loading,
                  onPressed: !active || _loading == true
                      ? null
                      : () {
                          setState(() {
                            _loading = true;
                          });
                          verifyOtp(
                              context, widget.verificationId, smsCode.text);
                          setState(() {
                            _loading = false;
                          });
                        }),
              optionB(context,
                  text:
                      "بياناتك آمنة، ولن يتم مشاركتها مع أي طرف ثالث لمزيد من التفاصيل ",
                  option: "سياسة الخصوصية", onPressed: () {
                launchURL(
                    "https://sites.google.com/view/sayaaratukcom-privacy-policy");
              })
            ],
          ),
        ),
      ),
    );
  }
}
