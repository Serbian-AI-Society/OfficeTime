import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';

class NoMessagesContainer extends StatelessWidget {
  const NoMessagesContainer({super.key, required this.filename});

  final String? filename;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            "assets/Send.svg",
            colorFilter: const ColorFilter.mode(lightGray, BlendMode.srcIn),
            width: 60,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Nema poruka! Započnite dopisivanje o dokumentu '${filename ?? "null"}'",
            style: const TextStyle(color: lightGray, fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
