import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sayaaratukcom/styles/colors.dart';
import 'package:sayaaratukcom/screens/pages/home.dart';
import 'package:sayaaratukcom/screens/pages/more.dart';
import 'package:sayaaratukcom/screens/pages/notifications.dart';
import 'package:sayaaratukcom/screens/pages/orders.dart';
import 'package:uicons/uicons.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

int selectedIndex = 0;

class _NavigationState extends State<Navigation> {
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> page = [
    const Home(),
    const Orders(),
    const Notifications(),
    const More()
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: page[selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              border: Border(
            top: BorderSide(width: 1, color: AppColors.highlight2),
          )),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            unselectedItemColor: AppColors.highlight1,
            selectedItemColor: Colors.black,
            selectedFontSize: 15,
            unselectedFontSize: 15,
            iconSize: 22,
            onTap: onItemTapped,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(UIcons.regularRounded.home),
                  activeIcon: Icon(UIcons.solidRounded.home),
                  label: "الرئيسية"),
              BottomNavigationBarItem(
                  icon: Icon(UIcons.regularRounded.car_side),
                  activeIcon: Icon(UIcons.solidRounded.car_side),
                  label: "الطلبات"),
              BottomNavigationBarItem(
                  icon: Icon(UIcons.regularRounded.bell),
                  activeIcon: Icon(UIcons.solidRounded.bell),
                  label: "الإشعارات"),
              BottomNavigationBarItem(
                  icon: Icon(UIcons.regularRounded.user),
                  activeIcon: Icon(UIcons.solidRounded.user),
                  label: "المزيد"),
            ],
          ),
        ),
      ),
    );
  }
}
