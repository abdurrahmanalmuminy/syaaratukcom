import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sayaaratukcom/models/chat_model.dart';
import 'package:sayaaratukcom/models/notification_model.dart';
import 'package:sayaaratukcom/models/offer_model.dart';
import 'package:sayaaratukcom/models/order_model.dart';
import 'package:sayaaratukcom/models/transaction_model.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/screens/chat.dart';
import 'package:sayaaratukcom/screens/wallet.dart';
import 'package:sayaaratukcom/screens/welcome.dart';
import 'package:sayaaratukcom/styles/colors.dart';
import 'package:sayaaratukcom/models/services.dart';
import 'package:sayaaratukcom/screens/offer.dart';
import 'package:sayaaratukcom/screens/order_page.dart';
import 'package:sayaaratukcom/screens/order_path.dart';
import 'package:sayaaratukcom/screens/service_page.dart';
import 'package:sayaaratukcom/utils/format_timestamp.dart';
import 'package:uicons/uicons.dart';

Widget primaryButton(context, text,
    {void Function()? onPressed, backgroundColor, bool? loading}) {
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
        child: loading == true
            ? const CircularProgressIndicator(color: Colors.black)
            : Text(
                text,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
      ),
    ),
  );
}

Widget heading(context,
    {required String title, required String subTitle, bool? small}) {
  return Padding(
    padding:
        small == true ? EdgeInsets.zero : const EdgeInsets.only(bottom: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: small == true
                ? Theme.of(context).textTheme.titleMedium
                : Theme.of(context).textTheme.titleLarge),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.titleSmall,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        )
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
    bool? multiline,
    onTap,
    focus,
    TextDirection? direction,
    TextAlign? align,
    Function(String)? onChanged}) {
  return TextField(
    controller: controller,
    textInputAction: TextInputAction.go,
    keyboardType: type,
    readOnly: readOnly ?? false,
    onTap: onTap,
    autofocus: focus ?? false,
    maxLines: multiline == true ? 3 : null,
    textAlign: align ?? TextAlign.start,
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
    textDirection: direction,
    onChanged: onChanged,
  );
}

Widget dropDown(
    {required String value,
    required IconData icon,
    required List<String> items,
    Function(String?)? onChanged}) {
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

Widget choose(
    {onPressed,
    required IconData icon,
    required String hint,
    required String indicator,
    controller}) {
  return TextField(
    controller: controller,
    readOnly: true,
    onTap: onPressed,
    decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: AppColors.highlight3),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.5),
            borderRadius: BorderRadius.circular(10)),
        hintText: hint,
        hintStyle: TextStyle(color: AppColors.highlight1),
        prefixIcon: Icon(icon, color: AppColors.highlight1, size: 20),
        suffixIcon: Container(
          width: 150,
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(indicator),
              Icon(UIcons.regularRounded.angle_small_left,
                  color: AppColors.highlight1, size: 20),
            ],
          ),
        )),
    textDirection: TextDirection.rtl,
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

AppBar appBar(context, {required String title}) {
  return AppBar(
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

AppBar pageBar(context, {required String title, List<Widget>? actions}) {
  return AppBar(
    backgroundColor: Colors.white,
    leadingWidth: double.infinity,
    leading: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(UIcons.regularRounded.angle_right)),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    ),
    actions: actions,
  );
}

Widget section(context, {required String title, bool? noPadding}) {
  return Padding(
    padding: noPadding == true
        ? EdgeInsets.zero
        : const EdgeInsets.symmetric(horizontal: 15),
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

Widget service(context, {required ServiceModel serviceItem}) {
  return ElevatedButton(
    onPressed: () {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => userProfile.uid != ""
              ? OrderService(service: serviceItem)
              : const Welcome()));
    },
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
          serviceItem.label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Expanded(
          child: Image.asset(serviceItem.asset,
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
        color: status == "ملغي"
            ? AppColors.red
            : status == "في إنتظار العروض"
                ? Colors.yellow.shade700
                : const Color(0xFF00A911),
        borderRadius: BorderRadius.circular(100)),
    child: Text(status,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12)),
  );
}

Widget order(context, OrderModel order) {
  return InkWell(
    onTap: () {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => OrderPage(order: order),
          fullscreenDialog: true));
    },
    child: ListTile(
      isThreeLine: true,
      leading: Icon(UIcons.regularRounded.car_side),
      trailing: Icon(UIcons.regularRounded.angle_small_left),
      title: Text(
        "${order.service.label} - ${timeAgo(order.createdAt)}",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: order.description != ""
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(order.description),
                gap(height: 2),
                statusItem(status: order.status)
              ],
            )
          : Row(
              children: [
                statusItem(status: order.status),
              ],
            ),
    ),
  );
}

Widget notification(context, NotificationModel notification) {
  return InkWell(
    onTap: () {},
    child: ListTile(
      isThreeLine: true,
      trailing: Icon(UIcons.regularRounded.angle_small_left),
      title: Text(
        "${notification.title} - ${timeAgo(notification.sentAt)}",
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(notification.content),
    ),
  );
}

Widget profile(context, void Function() uploadAvatar) {
  return ListTile(
      leading: userProfile.avatarUrl != ""
          ? avatar(context, uploadAvatar)
          : InkWell(
              onTap: uploadAvatar,
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(
                  UIcons.regularRounded.user,
                  color: Colors.black,
                ),
              ),
            ),
      trailing: TextButton(
        child: Icon(
          UIcons.regularRounded.wallet,
          color: Colors.black,
        ),
        onPressed: () {
          showWallet(context);
        },
      ),
      title: const Text("مرحباً"),
      subtitle: Text(
        userProfile.name,
        style: Theme.of(context).textTheme.titleLarge,
        overflow: TextOverflow.ellipsis,
      ));
}

Widget avatar(context, void Function() uploadAvatar) {
  return InkWell(
    onTap: uploadAvatar,
    child: CachedNetworkImage(
      width: 50,
      height: 50,
      imageUrl: userProfile.avatarUrl,
      imageBuilder: (context, imageProvioder) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            image: DecorationImage(
                image: imageProvioder,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter),
          ),
        );
      },
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(100)),
        child: Icon(
          UIcons.regularRounded.user,
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget moreItem(context,
    {required String label,
    required IconData icon,
    void Function()? onTap,
    trailing,
    Color? color}) {
  return InkWell(
    onTap: onTap,
    child: ListTile(
        leading: Icon(icon, size: 20, color: color),
        title: Text(label),
        textColor: color,
        trailing: trailing),
  );
}

Widget switchTile(context,
    {required Widget switchWidget,
    required String title,
    required String subTitle}) {
  return ListTile(
    contentPadding: const EdgeInsets.only(),
    trailing: switchWidget,
    title: Text(title, style: Theme.of(context).textTheme.titleMedium),
    subtitle: Text(subTitle, style: Theme.of(context).textTheme.titleSmall),
  );
}

Widget grantPermission(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("يجب السماح للتطبيق بالوصول إلى الموقع",
          style: Theme.of(context).textTheme.titleMedium),
      gap(height: 10),
      SizedBox(
        width: 150,
        child: primaryButton(context, "السماح", onPressed: () {
          AppSettings.openAppSettings(type: AppSettingsType.location);
        }),
      )
    ],
  );
}

Widget orderPathIndicator(
    context, List addresses, LatLng origin, LatLng destination) {
  return OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) =>
                OrderPath(origin: origin, destination: destination),
            fullscreenDialog: true));
      },
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: AppColors.highlight2, width: 1.5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(10)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: heading(context,
                  title: "عنوان الإستلام", subTitle: addresses[0], small: true),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: VerticalDivider(
                thickness: 1.5,
                color: AppColors.highlight2,
              ),
            ),
            Expanded(
              child: heading(context,
                  title: "عنوان التوصيل", subTitle: addresses[1], small: true),
            ),
          ],
        ),
      ));
}

Widget offer(context, OfferModel offer,
    {bool? clickable, required OrderModel order, bool? chat}) {
  return ElevatedButton(
    onPressed: clickable != false
        ? () {
            showOffer(context, offer, order);
          }
        : () {},
    style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.highlight3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
    child: Column(
      children: [
        Row(
          children: [
            offer.serviceProvider[2] != ""
                ? CachedNetworkImage(
                    width: 50,
                    height: 50,
                    imageUrl: offer.serviceProvider[2],
                    imageBuilder: (context, imageProvioder) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                              image: imageProvioder,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter),
                        ),
                      );
                    },
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(100)),
                    child: Icon(
                      UIcons.regularRounded.user,
                      color: Colors.black,
                    ),
                  ),
            gap(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(offer.serviceProvider[1],
                    style: const TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            const Expanded(child: SizedBox()),
            RichText(
              text: TextSpan(
                  text: offer.price.toString(),
                  style: Theme.of(context).textTheme.titleLarge,
                  children: <TextSpan>[
                    TextSpan(
                      text: "ر.س",
                      style:
                          TextStyle(fontSize: 15, color: AppColors.highlight1),
                    )
                  ]),
            ),
          ],
        ),
        chat == true ? Divider(color: AppColors.highlight2) : const SizedBox(),
        chat == true
            ? moreItem(context,
                label: "الدردشة",
                icon: UIcons.regularRounded.comment,
                trailing: Icon(UIcons.regularRounded.angle_small_left),
                onTap: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => Chat(offer: offer),
                    fullscreenDialog: true));
              })
            : const SizedBox()
      ],
    ),
  );
}

Widget transaction(context, TransactionModel transaction) {
  return InkWell(
    onTap: () {},
    child: ListTile(
      trailing: Text("${transaction.amount} ر.س",
          style: Theme.of(context).textTheme.titleSmall),
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(
        transaction.transaction,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(formatTimestamp(transaction.dueAt)),
      shape: Border(bottom: BorderSide(width: 1, color: AppColors.highlight3)),
    ),
  );
}

Widget errorOccurred() {
  return const Center(
    child: Text(
      "حصل خطأ",
      style: TextStyle(fontSize: 16),
    ),
  );
}

Widget noData({String? customNoData}) {
  return Center(
    child: Text(
      customNoData ?? "لاتوجد معلومات لعرضها",
      style: const TextStyle(fontSize: 16),
    ),
  );
}

Widget note(note) {
  return Container(
    constraints: const BoxConstraints(maxWidth: 350),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: AppColors.highlight, borderRadius: BorderRadius.circular(10)),
    child: Text(note,
        style: const TextStyle(color: Colors.white),
        textAlign: TextAlign.center),
  );
}

Widget chatItem(ChatModel chat) {
  bool me = chat.user == userProfile.uid;
  return Row(
    mainAxisAlignment:
        me != true ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      Container(
        constraints: const BoxConstraints(maxWidth: 250),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        margin: const EdgeInsets.only(bottom: 3),
        decoration: BoxDecoration(
            color: me != true ? AppColors.highlight3 : AppColors.primaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment:
              me != true ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              chat.message,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            gap(height: 1),
            Text(
              timestampTime(chat.sentAt),
              textDirection: TextDirection.ltr,
              style:
                  TextStyle(fontSize: 10, color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget orDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: AppColors.highlight2,
            height: 1.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text("أو",
              style: TextStyle(color: AppColors.highlight1, fontSize: 15)),
        ),
        Expanded(
          child: Divider(
            color: AppColors.highlight2,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget askToLogin(context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text("يجب تسجيل الدخول أو إنشاء حساب جديد",
          style: Theme.of(context).textTheme.titleMedium),
      gap(height: 10),
      SizedBox(
        width: 200,
        child: primaryButton(context, "تسجيل الدخول", onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Welcome()));
        }),
      )
    ],
  );
}
