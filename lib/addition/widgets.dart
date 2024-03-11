import 'package:flutter/material.dart';
import 'package:sayaaratukcom/addition/colors.dart';
import 'package:uicons/uicons.dart';

Widget primaryButton(context, text,
    {void Function()? onPressed, backgroundColor}) {
  return SizedBox(
    height: 50,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        disabledBackgroundColor: AppColors.highlight2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    ),
  );
}

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
    {controller,
    TextInputType? type,
    required String hint,
    required IconData icon,
    bool? readOnly,
    onTap,
    focus,
    Function(String)? onChanged}) {
  return TextField(
    controller: controller,
    textInputAction: TextInputAction.go,
    keyboardType: type,
    readOnly: readOnly ?? false,
    onTap: onTap,
    autofocus: focus ?? false,
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
    onChanged: onChanged,
  );
}

Widget dropDown(
    {required String value,
    required IconData icon,
    required List<String> items,
    onChanged}) {
  return DropdownButtonFormField(
    value: value,
    iconSize: 0,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: AppColors.highlight3),
          borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1.5),
          borderRadius: BorderRadius.circular(10)),
      hintStyle: TextStyle(color: AppColors.highlight1),
      prefixIcon: Icon(icon, color: AppColors.highlight1, size: 20),
      suffixIcon: Icon(UIcons.regularRounded.angle_small_down, color: AppColors.highlight1, size: 20)
    ),
    isExpanded: true,
    items: items.map((String items) {
      return DropdownMenuItem(
        value: items,
        child: Text(items),
      );
    }).toList(),
    onChanged: onChanged,
  );
}

Widget gap({double? height, double? width}) {
  return SizedBox(height: height ?? 0, width: width ?? 0);
}

AppBar backBar(context) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(UIcons.regularRounded.angle_right)),
  );
}

Widget optionB(context, {text, option, onPressed}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(padding: const EdgeInsets.all(10)),
    child: RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: Theme.of(context).textTheme.bodyMedium,
        children: <TextSpan>[
          TextSpan(
            text: option,
            style: const TextStyle(fontWeight: FontWeight.w600),
          )
        ],
      ),
    ),
  );
}
