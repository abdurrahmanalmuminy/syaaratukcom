import 'package:flutter/material.dart';
import 'package:sayaaratukcom/services/register_user.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
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

  @override
  Widget build(BuildContext context) {
    void updateButton() {
      setState(() {
        active = name.text.isNotEmpty ? true : false;
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
              gap(height: 10),
              dropDown(
                  value: gender,
                  icon: UIcons.regularRounded.venus,
                  items: ["ذكر", "أنثى"],
                  onChanged: (String? newValue) {
                    setState(() {
                      gender = newValue!;
                    });
                  }),
              const Expanded(child: SizedBox()),
              primaryButton(context, "التالي",
                  onPressed: !active
                      ? null
                      : () {
                          signUp(context,
                              name: name.text,
                              email: email.text,
                              gender: gender);
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