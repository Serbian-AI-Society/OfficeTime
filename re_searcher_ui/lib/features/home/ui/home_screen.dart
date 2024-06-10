import 'dart:js' as js;

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
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "RE:searcher",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Snađi se pametno.",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(40),
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: darkGray,
                        border: Border.all(width: 2, color: lightGray),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Text(
                              "RE:searcher je moćna alatka koja pomoću magije✨ veštačke inteligencije ubrzava Vaš istraživački posao! 📔 Nakon što učitate željeni dokument u samu alatku, imate mogućnost da razgovarate sa AI modelom o istom dokumentu. 🤖\n\nAI model može za Vas generisati sažetak dokumenta u formatu lepljivih beleški, dati Vam odgovor na pitanja zasnovan na sadržaju dokumenta i sugerisati potencijalni nastavak razgovora o temi u samom dokumentu. 🖊\n\nVelika prednost RE:searchera je to što će Vam na pitanja odgovarati sa rečenicama i citatima iz samog dokumenta o kom se govori, te je analiza dokumenta mnogostruko olakšana. 👀",
                              style: TextStyle(color: white, fontSize: 18),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Započnite odabirom dokumenta iz liste levo! 🤗",
                              style: TextStyle(
                                  color: primaryGreen,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  HomeAvatar(
                                      fileName: "assets/vuk.jpg",
                                      url: "https://github.com/vukca"),
                                  HomeAvatar(
                                      fileName: "assets/laslo.jpg",
                                      url: "https://github.com/laslo-uri"),
                                  HomeAvatar(
                                      fileName: "assets/tara.jpg",
                                      url: "https://github.com/tara-pogancev"),
                                  HomeAvatar(
                                      fileName: "assets/milan.jpg",
                                      url: "https://github.com/milanp98"),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeAvatar extends StatelessWidget {
  const HomeAvatar({super.key, required this.fileName, required this.url});

  final String fileName;
  final String url;

  void _openUrl() async {
    js.context.callMethod('open', [url]);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          _openUrl();
        },
        child: CircleAvatar(
          backgroundImage: AssetImage(fileName),
          radius: 100,
        ),
      ),
    );
  }
}
