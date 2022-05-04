import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'src/configs/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      onGenerateRoute: AppRoutes.generatedRoute,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/splash',
    );
  }
}
