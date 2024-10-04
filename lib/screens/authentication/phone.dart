import 'package:flutter/material.dart';
import 'package:sayaaratukcom/services/auth_service.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/utils/launch_url.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController phone = TextEditingController();
  bool active = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    void updateButton() {
      setState(() {
        active = phone.text.isNotEmpty ? true : false;
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
              Hero(
                tag: "phone_field",
                child: Material(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      heading(context,
                          title: "تسجيل الدخول",
                          subTitle:
                              "لتسجيل الدخول أو إنشاء حساب، أدخل رقم هاتفك"),
                      textField(context,
                          controller: phone,
                          hint: "رقم الهاتف (..55)",
                          type: TextInputType.phone,
                          icon: UIcons.regularRounded.smartphone,
                          focus: true,
                          direction: TextDirection.ltr,
                          onChanged: (value) {
                        updateButton();
                      }),
                    ],
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              primaryButton(context, "التحقق",
                  loading: _loading,
                  onPressed: !active || _loading == true
                      ? null
                      : () {
                          setState(() {
                            _loading = true;
                          });
                          verifyPhoneNumber(context, phone.text);
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
