import 'package:flutter/material.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class WorkWithUs extends StatefulWidget {
  const WorkWithUs({super.key});

  @override
  State<WorkWithUs> createState() => _WorkWithUsState();
}

class _WorkWithUsState extends State<WorkWithUs> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController vehicle = TextEditingController();
  bool active = false;

  @override
  Widget build(BuildContext context) {
    void updateButton() {
      setState(() {
        active = phone.text.isNotEmpty ? true : false;
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
              Material(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    heading(context,
                        title: "إعمل معنا",
                        subTitle:
                            "لتقديم طلب العمل معنا، أدخل المعلومات التالية"),
                    textField(context,
                        controller: phone,
                        hint: "الإسم الثلاثي",
                        type: TextInputType.text,
                        icon: UIcons.regularRounded.user,
                        focus: true,
                        direction: TextDirection.ltr,
                        align: TextAlign.right, onChanged: (value) {
                      updateButton();
                    }),
                    gap(height: 10),
                    textField(context,
                        controller: phone,
                        hint: "رقم الهاتف (..55)",
                        type: TextInputType.phone,
                        icon: UIcons.regularRounded.smartphone,
                        focus: true,
                        direction: TextDirection.ltr,
                        align: TextAlign.right, onChanged: (value) {
                      updateButton();
                    }),
                    gap(height: 10),
                    textField(context,
                        controller: vehicle,
                        hint: "المركبة",
                        icon: UIcons.regularRounded.car_side,
                        onChanged: (value) {
                      updateButton();
                    }),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              primaryButton(context, "قدم الطلب",
                  onPressed: !active
                      ? null
                      : () {}),
              optionB(context,
                  text: "بتقديم طلبك للعمل معنا فأنت تقر وتوافق على ",
                  option: "سياسة الإستخدام و سياسة الخصوصية")
            ],
          ),
        ),
      ),
    );
  }
}