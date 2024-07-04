import 'package:flutter/material.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(UIcons.regularRounded.cross)),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(UIcons.solidRounded.layer_plus,
                  color: Colors.green, size: 50),
              gap(height: 10),
              Text("تم قبول العرض",
                  style: Theme.of(context).textTheme.titleLarge),
              Text("لقد تم قبول العرض، وسيتواصل معك مزود الخدمة قريباً..",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
