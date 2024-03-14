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
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: AppColors.highlight3),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        hintStyle: TextStyle(color: AppColors.highlight1),
        prefixIcon: Icon(icon, color: AppColors.highlight1, size: 20),
        suffixIcon: Icon(UIcons.regularRounded.angle_small_down,
            color: AppColors.highlight1, size: 20)),
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

Widget minimizedWallet() {
  return TextButton(
    onPressed: () {},
    style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2)),
    child: Row(
      children: [
        Icon(
          UIcons.solidRounded.wallet,
          color: Colors.black,
        ),
        const SizedBox(width: 5),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("الرصيد", style: TextStyle(color: Colors.black)),
            Text(
              "62.00 ريال",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            )
          ],
        )
      ],
    ),
  );
}

AppBar appBar(context, {required String title}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    leadingWidth: 200,
    leading: Padding(
      padding: const EdgeInsets.only(right: 15, top: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
  );
}

Widget section(context, {required String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    ),
  );
}

Widget service(context, {required String label, required String asset}) {
  return ElevatedButton(
    onPressed: () {},
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.only(top: 10, right: 10),
      elevation: 0,
      backgroundColor: AppColors.highlight3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Expanded(
          child: Image.asset(asset,
              fit: BoxFit.cover, alignment: Alignment.topRight),
        )
      ],
    ),
  );
}

Widget statusItem({required String status}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
        color: const Color(0xFF00A911),
        borderRadius: BorderRadius.circular(100)),
    child: Text(status,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
  );
}

Widget order(context,
    {required String subject,
    required String content,
    required String time,
    required String status}) {
  return InkWell(
    onTap: () {},
    child: ListTile(
      isThreeLine: true,
      leading: Icon(UIcons.regularRounded.car_side),
      trailing: Icon(UIcons.regularRounded.angle_small_left),
      title: Text(
        "$subject - $time",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(content), gap(height: 2), statusItem(status: status)],
      ),
    ),
  );
}

Widget notification(context,
    {required String subject, required String message, required String time}) {
  return InkWell(
    onTap: () {},
    child: ListTile(
      isThreeLine: true,
      trailing: Icon(UIcons.regularRounded.angle_small_left),
      title: Text(
        "$subject - $time",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(message),
    ),
  );
}

Widget profile(context) {
  return ListTile(
      leading: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(100)),
        child: const Center(
          child: Text(
            "ع",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      trailing: TextButton(child: Icon(UIcons.regularRounded.wallet), onPressed: (){},),
      title: const Text("مساء الخير"),
      subtitle: Text(
        "عبد الرحمن",
        style: Theme.of(context).textTheme.titleLarge,
      ));
}

Widget moreItem(context, {required String label, required IconData icon}) {
  return InkWell(
    onTap: () {},
    child: ListTile(
        leading: Icon(icon, size: 20),
        title: Text(label, style: Theme.of(context).textTheme.bodyLarge)),
  );
}
