import 'package:flutter/material.dart';

class Nastaveni extends StatefulWidget{
  const Nastaveni({super.key});

  @override
  State<Nastaveni> createState() => _NastaveniState();
}

class _NastaveniState extends State<Nastaveni> {
  bool isDarkMode = false;
  String lang = "Čeština";
  var languages = ["Čeština", "Angličtina"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBar(),
        body: nastaveniBody()
    );
  }

  Column nastaveniBody() {
    return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 3),
                      Text(
                        "Tmavý režim",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 5),
                        Icon(Icons.wb_sunny_outlined, size: 30),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      Switch(value: isDarkMode,
                      onChanged: (bool value) {
                        setState(()
                        {
                          isDarkMode = value;
                        }
                      );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "Jazyk",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                        )
                      )
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 7),
                        Icon(Icons.language, size: 30)
                      ],
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    children: [
                      DropdownButton(
                        value: lang,
                        items: languages.map((String languages){
                          return DropdownMenuItem(value: languages, child: Text(languages));
                        }).toList(),
                        onChanged: (String? newLang){
                          setState((){
                            lang = newLang!;
                          }
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }
}