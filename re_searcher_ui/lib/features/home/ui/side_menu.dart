import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/model/active_document.dart';
import 'package:re_searcher_ui/core/router/app_router.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';
import 'package:re_searcher_ui/features/chat/bloc/chat_bloc.dart';

class SideMenu extends StatelessWidget {
  SideMenu({
    super.key,
    this.isHome = false,
  });

  final bool isHome;

  final _chatBloc = IC.getIt<ChatBloc>();

  final List<ActiveDocument> availableDocuments = [
    ActiveDocument(
        name: "Don Kihot",
        filename: "don_kihot.pdf",
        description: "Čuvena novela Servantesa."),
    ActiveDocument(
        name: "Vino",
        filename: "vino.pdf",
        description: "Sve o vinu i vinarstvu."),
    ActiveDocument(
        name: "Iron Maiden",
        filename: "iron_maiden.pdf",
        description: "Biografija poznatog benda."),
    ActiveDocument(
        name: "Mačka",
        filename: "macka.pdf",
        description: "Informacije o mačkama."),
    ActiveDocument(
        name: "Orbitalni istraživač Marsa",
        filename: "orbitalni_istrazivac_marsa.pdf",
        description: "Misi Marsovog istraživača.")
  ];

  void _navigateHome(BuildContext context) {
    if (!isHome) {
      context.go(Routes.home);
    }
  }

  void _navigateChat(BuildContext context, ActiveDocument document) {
    _chatBloc.add(SetActiveDocumentEvent(document: document));
    if (isHome) {
      context.go(Routes.chat);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: const BoxDecoration(
        color: darkGray,
        border: Border(
          right: BorderSide(width: 3, color: lightGray),
        ),
      ),
      child: BlocBuilder<ChatBloc, ChatState>(
        bloc: _chatBloc,
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: SvgPicture.asset(
                  "assets/Logo.svg",
                  width: 240,
                ),
              ),
              MenuItem(
                isHome: true,
                isActive: isHome,
                level: 1,
                onClick: () {
                  _navigateHome(context);
                },
              ),
              MenuItem(
                isDocuments: true,
                isActive: false,
                level: 1,
                onClick: () {},
              ),
              ...availableDocuments.map(
                (doc) {
                  return MenuItem(
                    level: 2,
                    document: doc,
                    isActive:
                        (state.currentDocument?.name == doc.name) && !isHome,
                    onClick: () {
                      _navigateChat(context, doc);
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.level,
    this.document,
    required this.isActive,
    this.isHome = false,
    this.isDocuments = false,
    required this.onClick,
  });

  final double level;
  final ActiveDocument? document;
  final bool isActive;
  final bool isHome;
  final bool isDocuments;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    IconData icon;
    if (isHome) {
      icon = Icons.home;
    } else if (isDocuments) {
      icon = Icons.document_scanner;
    } else {
      icon = Icons.document_scanner_outlined;
    }

    String text;
    if (isHome) {
      text = "Početna";
    } else if (isDocuments) {
      text = "Dokumenti";
    } else {
      text = document!.name!;
    }

    double spacing = 20 * (level - 1);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: FilledButton(
        onPressed: () {
          onClick();
        },
        style: TextButton.styleFrom(
          backgroundColor: (!isActive) ? darkGray : mediumGray,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: spacing),
            if (isActive)
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: SvgPicture.asset(
                  "assets/Line.svg",
                  height: 44,
                ),
              )
            else
              const SizedBox(
                width: 17,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    text,
                    style: const TextStyle(color: white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
