import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sayaaratukcom/addition/colors.dart';
import 'package:sayaaratukcom/addition/padding.dart';
import 'package:sayaaratukcom/addition/services.dart';
import 'package:sayaaratukcom/addition/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<String> imageList = [
      'assets/images/Ad.jpg',
      'assets/images/Ad.jpg',
      'assets/images/Ad.jpg',
    ];

    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("مساء الخير"),
              Text(
                "عبد الرحمن",
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: minimizedWallet(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            gap(height: 10),
            CarouselSlider(
              options: CarouselOptions(
                  height: 180,
                  viewportFraction: 1.0,
                  autoPlay: true,
                  initialPage: 0,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  }),
              items: imageList
                  .map(
                    (item) => imageList.isEmpty
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                  color: AppColors.primaryColor),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                width: MediaQuery.of(context).size.width,
                                item,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  )
                  .toList(),
            ),
            gap(height: 5),
            DotsIndicator(
              dotsCount: 3,
              position: currentIndex,
              decorator: DotsDecorator(
                size: const Size(9.0, 9.0),
                activeSize: const Size(25, 9.0),
                color: AppColors.highlight2,
                activeColor: AppColors.highlight,
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
            gap(height: 25),
            section(context, title: "خدماتنا"),
            GridView.builder(
              padding: bodyPadding,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.8,
                  crossAxisCount: (screenWidth / 150).round()),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                return service(context,
                    label: services[index].label, asset: services[index].asset);
              },
            )
          ],
        ),
      ),
    );
  }
}
