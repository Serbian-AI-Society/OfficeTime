import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/router/app_router.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';

void main() {
  IC.setUp();
    GoogleFonts.config.allowRuntimeFetching = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.router(
        (Routes.home),
      ),
      debugShowCheckedModeBanner: false,
      title: 'RE:searcher',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: lightGreen),
        useMaterial3: true,
      ),
    );
  }
}
