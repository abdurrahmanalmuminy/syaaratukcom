import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/services/register_provider.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class WorkWithUs extends StatefulWidget {
  final String phone;
  const WorkWithUs({super.key, required this.phone});

  @override
  State<WorkWithUs> createState() => _WorkWithUsState();
}

class _WorkWithUsState extends State<WorkWithUs> {
  TextEditingController name = TextEditingController();
  TextEditingController identity = TextEditingController();
  TextEditingController phone = TextEditingController();
  String selectedService = "فحص";
  bool active = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    phone.text = widget.phone;
  }

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  heading(context,
                      title: "إعمل معنا",
                      subTitle:
                          "لتقديم طلب العمل معنا، أدخل المعلومات التالية"),
                  textField(context,
                      controller: name,
                      hint: "الإسم الثلاثي",
                      type: TextInputType.text,
                      icon: UIcons.regularRounded.user,
                      direction: TextDirection.ltr,
                      onChanged: (value) {
                    updateButton();
                  }),
                  gap(height: 10),
                  textField(context,
                      controller: identity,
                      hint: "رقم الهوية",
                      type: TextInputType.number,
                      icon: UIcons.regularRounded.id_badge,
                      direction: TextDirection.ltr,
                      onChanged: (value) {
                    updateButton();
                  }),
                  gap(height: 10),
                  textField(context,
                      controller: phone,
                      readOnly: true,
                      hint: "رقم الهاتف (..55)",
                      type: TextInputType.phone,
                      icon: UIcons.regularRounded.smartphone,
                      direction: TextDirection.ltr,
                      onChanged: (value) {
                    updateButton();
                  }),
                  gap(height: 10),
                  dropDown(
                      value: selectedService,
                      icon: UIcons.regularRounded.car_side,
                      items: [
                        "فحص",
                        "إطارات",
                        "سطحة",
                        "المفاتيح",
                        "غسيل",
                        "ورشة"
                      ],
                      onChanged: (value) {
                        setState(() {
                          selectedService = value!;
                        });
                      })
                ],
              ),
              const Expanded(child: SizedBox()),
              primaryButton(context, "قدم الطلب",
                  loading: _loading,
                  onPressed: !active || _loading == true
                      ? null
                      : () {
                          setState(() {
                            _loading = true;
                          });
                          registerProvider(context,
                              uid: userProfile.uid,
                              phone: phone.text,
                              identity: identity.text,
                              name: name.text,
                              service: selectedService);
                        }),
              optionB(context,
                  text:
                      "للعمل معنا، يجب امتلاك رخصة واستمارة سارية المفعول وامتلاك سجل تجاري للورشات المتنقلة",
                  option: "")
            ],
          ),
        ),
      ),
    );
  }
}
