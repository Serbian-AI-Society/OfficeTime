import 'package:flutter/material.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';
import 'package:re_searcher_ui/features/home/ui/side_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mediumGray,
      body: Row(
        children: [
          SideMenu(
            isHome: true,
          ),
        ],
      ),
    );
  }
}
