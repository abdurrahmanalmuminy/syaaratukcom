import 'package:flutter/material.dart';
import 'package:sayaaratukcom/services/request_support.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  TextEditingController title = TextEditingController();
  TextEditingController message = TextEditingController();
  bool active = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    void updateButton() {
      setState(() {
        active =
            title.text.isNotEmpty && message.text.isNotEmpty ? true : false;
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
                      title: "الدعم الفني",
                      subTitle: "تواجه مشكلة؟ احصل على المشكلة من الدعم الفني"),
                  textField(context,
                      controller: title,
                      hint: "العنوان",
                      type: TextInputType.text,
                      icon: UIcons.regularRounded.headset,
                      direction: TextDirection.ltr, onChanged: (value) {
                    updateButton();
                  }),
                  gap(height: 10),
                  textField(context,
                      controller: message,
                      hint: "مالذي تواجهه؟",
                      type: TextInputType.text,
                      icon: UIcons.regularRounded.align_justify,
                      direction: TextDirection.ltr,
                      multiline: true, onChanged: (value) {
                    updateButton();
                  }),
                ],
              ),
              const Expanded(child: SizedBox()),
              primaryButton(context, "احصل على مساعدة",
                  loading: _loading,
                  onPressed: !active || _loading == true
                      ? null
                      : () {
                          setState(() {
                            _loading = true;
                          });
                          requestSupport(context,
                              title: title.text, message: message.text);
                        }),
              optionB(context,
                  text:
                      "بمجرد إرسال طلب المساعدة، سيتم التواصل معك من قبل فريقنا في اقرب وقت ممكن",
                  option: "")
            ],
          ),
        ),
      ),
    );
  }
}
