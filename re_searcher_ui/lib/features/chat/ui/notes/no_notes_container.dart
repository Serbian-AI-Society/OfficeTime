import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';

class NoNotesContainer extends StatelessWidget {
  const NoNotesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/Doc.svg",
            color: lightGray,
            width: 40,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Nemate beleški! Zamolite AI da kreira belešku za vas! 😄🧠",
            style: TextStyle(color: lightGray, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
