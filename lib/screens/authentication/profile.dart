import 'package:flutter/material.dart';
import 'package:sayaaratukcom/services/register_user.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/utils/launch_url.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  String gender = "ذكر";

  bool active = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    void updateButton() {
      setState(() {
        active = name.text.isNotEmpty ? true : false;
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
                  title: "خطوة أخيرة",
                  subTitle: "لإعداد حسابك الشخصي أدخل المعلومات التالية"),
              textField(context,
                  controller: name,
                  hint: "إسم المستخدم",
                  type: TextInputType.name,
                  icon: UIcons.regularRounded.user,
                  focus: true, onChanged: (value) {
                updateButton();
              }),
              gap(height: 10),
              textField(context,
                  controller: email,
                  hint: "(اختياري)البريد الإلكتروني",
                  type: TextInputType.emailAddress,
                  icon: UIcons.regularRounded.envelope, onChanged: (value) {
                updateButton();
              }),
              const Expanded(child: SizedBox()),
              primaryButton(context, "التالي",
                  loading: _loading,
                  onPressed: !active || _loading == true
                      ? null
                      : () {
                          setState(() {
                            _loading = true;
                          });
                          signUp(context,
                              name: name.text,
                              email: email.text,
                              gender: "");
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
