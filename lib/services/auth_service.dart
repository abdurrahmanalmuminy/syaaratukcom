// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sayaaratukcom/screens/authentication/profile.dart';
import 'package:sayaaratukcom/screens/authentication/verification.dart';
import 'package:sayaaratukcom/screens/welcome.dart';
import 'package:sayaaratukcom/services/register_user.dart';
import 'package:sayaaratukcom/widgets/progress_dialog.dart';
import 'package:sayaaratukcom/utils/translate_error.dart';
import 'package:sayaaratukcom/widgets/show_dialog.dart';
import 'package:sayaaratukcom/widgets/snack_bar.dart';

void verifyPhoneNumber(BuildContext context, String phone) async {
  Function closeProgressDialog = progressDialog(context);
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phone.contains("+966") ? phone : "+966$phone",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        showAlertDialog(context,
            title: "حدث خطأ", content: translateError(e.code));
        log(e.code);
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) =>
                Verification(verificationId: verificationId)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  } catch (e) {
    log(e.toString());
    snackBar(context, translateError(e.toString()));
  } finally {
    closeProgressDialog();
  }
}

void verifyOtp(BuildContext context, verificationId, smsCode) async {
  Function closeProgressDialog = progressDialog(context);
  try {
    FirebaseAuth auth = FirebaseAuth.instance;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await auth.signInWithCredential(credential);
    bool registered = await initUser();
    closeProgressDialog();
    if (registered) {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => const Navigator(), fullscreenDialog: true));
    } else {
      closeProgressDialog();
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => const Profile()));
    }
  } catch (e) {
    closeProgressDialog();
    log(e.toString());
    snackBar(context, translateError(e.toString()));
  }
}

void signOut(context) async {
  showAlertDialog(context,
      title: "تسجيل الخروج",
      content: "سيتم تسجيل الخروج بناءً على طلبك", onOk: () async {
    Function closeProgressDialog = progressDialog(context);
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();
      closeProgressDialog();
      Navigator.of(context).pushReplacement(CupertinoPageRoute(
        builder: (context) => const Welcome(),
        fullscreenDialog: true,
      ));
    } catch (e) {
      closeProgressDialog();
      log(e.toString());
      snackBar(context, translateError(e.toString()));
    }
  });
}
