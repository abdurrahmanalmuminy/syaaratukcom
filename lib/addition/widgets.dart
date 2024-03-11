import 'package:flutter/material.dart';
import 'package:sayaaratukcom/addition/colors.dart';

Widget heading(context, {required String title, required String subTitle}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        Text(subTitle, style: Theme.of(context).textTheme.titleSmall)
      ],
    ),
  );
}

TextField textField(context,
    {required String hint,
    required IconData icon,
    bool? readOnly,
    onTap,
    focusNode}) {
  return TextField(
    textInputAction: TextInputAction.go,
    readOnly: readOnly ?? false,
    onTap: onTap,
    focusNode: focusNode,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: AppColors.highlight3),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.5),
          borderRadius: BorderRadius.circular(10)),
      hintText: hint,
      hintStyle: TextStyle(color: AppColors.highlight1),
      prefixIcon: Icon(icon, color: AppColors.highlight1, size: 20),
    ),
    obscureText: false,
    textDirection: TextDirection.rtl,
    onChanged: (value) {},
  );
}

Widget gap({double? height, double? width}) {
  return SizedBox(height: height ?? 0, width: width ?? 0);
}
