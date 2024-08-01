import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sayaaratukcom/firebase_options.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/screens/authentication/profile.dart';
import 'package:sayaaratukcom/screens/menu/navigation.dart';
import 'package:sayaaratukcom/services/messaging_services.dart';
import 'package:sayaaratukcom/services/register_user.dart';
import 'package:sayaaratukcom/utils/change_notifier.dart';
import 'package:sayaaratukcom/styles/colors.dart';
import 'package:sayaaratukcom/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sayaaratukcom/screens/welcome.dart';

bool registered = false;
final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "Sayaaratukcom", options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
  );
  registered = await initUser();
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static const navigation = '/navigation';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سيارتك كوم',
      theme: ThemeData(
          splashFactory: NoSplash.splashFactory,
          fontFamily: "Rubik",
          colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              secondary: AppColors.primaryColor,
              onSecondary: Colors.black,
              error: AppColors.red,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.white,
              surface: AppColors.highlight3,
              onSurface: Colors.black),
          textTheme: const TextTheme(
            titleLarge: TextStyle(fontWeight: FontWeight.w600),
            displayMedium: TextStyle(fontWeight: FontWeight.w600),
          )),
      home: FirebaseAuth.instance.currentUser != null
          ? registered
              ? const Navigation()
              : const Profile()
          : const Welcome(),
      supportedLocales: L10n.all,
      locale: Provider.of<LocaleProvider>(context).currentLocale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
    );
  }
}
