import 'package:devanshhooda/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'modules/splash/views/ui/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ChargeMOD App',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primaryColor, brightness: Brightness.dark),
          useMaterial3: true,
        ));
  }
}
