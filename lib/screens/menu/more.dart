// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/screens/support.dart';
import 'package:sayaaratukcom/screens/work_with_us.dart';
import 'package:sayaaratukcom/services/auth_service.dart';
import 'package:sayaaratukcom/utils/launch_url.dart';
import 'package:sayaaratukcom/widgets/progress_dialog.dart';
import 'package:sayaaratukcom/widgets/snack_bar.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
    uploadFile();
  }

  Future uploadFile() async {
    final path = "avatars/${userProfile.uid}/${pickedFile!.name}";
    final file = File(pickedFile!.path!);

    //upload to firebase
    Function closeProgressDialog = progressDialog(context);
    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    final snapshot = await uploadTask!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    //update avatar
    FirebaseFirestore.instance
        .collection("users")
        .doc(userProfile.uid)
        .update({"avatarUrl": urlDownload});
    closeProgressDialog();
    snackBar(context, "تم تحديث الصورة الشخصة بنجاح، يرجى إعادة فتح التطبيق");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: "المزيد"),
      body: Column(
        children: [
          userProfile.uid != ""
              ? profile(context, selectFile)
              : askToLogin(context),
          gap(height: 25),
          moreItem(context,
              label: "إعمل معنا",
              icon: UIcons.regularRounded.briefcase, onTap: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => WorkWithUs(phone: userProfile.phone),
            ));
          }),
          moreItem(context,
              label: "سياسة الخصوصية",
              icon: UIcons.regularRounded.lock, onTap: () {
            launchURL(
                "https://sites.google.com/view/sayaaratukcom-privacy-policy");
          }),
          moreItem(context,
              label: "سياسة الخدمة",
              icon: UIcons.regularRounded.hand_holding_heart, onTap: () {
            launchURL(
                "https://sites.google.com/view/sayaaratukcom-terms-of-service");
          }),
          moreItem(context,
              label: "سياسة الدفع والإسترداد",
              icon: UIcons.regularRounded.credit_card, onTap: () {
            launchURL(
                "https://sites.google.com/view/sayaaratukcom-payment-refund");
          }),
          moreItem(context,
              label: "الدعم الفني", icon: UIcons.regularRounded.headset, onTap: () {
            Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => const Support(),
            ));
          }),
          userProfile.uid != ""
              ? moreItem(context,
                  label: "تسجيل الخروج",
                  icon: UIcons.regularRounded.sign_out_alt,
                  color: Colors.red, onTap: () {
                  signOut(context);
                })
              : const SizedBox(),
          userProfile.uid != ""
              ? moreItem(context,
                  label: "حذف الحساب",
                  icon: UIcons.regularRounded.trash,
                  color: Colors.red, onTap: () {
                  signOut(context);
                })
              : const SizedBox(),
          const Expanded(child: SizedBox()),
          TextButton(
            child: const Text(
              "الكون الجديد لتقنية المعلومات",
              style: TextStyle(color: Colors.blue),
            ),
            onPressed: () {
              launchURL("https://alkon.online");
            },
          ),
          gap(height: 15),
        ],
      ),
    );
  }
}
