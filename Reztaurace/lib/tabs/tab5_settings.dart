import 'package:flutter/material.dart';
import 'package:reztaurace/data/lang_data.dart';

import 'package:reztaurace/darkMode/setMode.dart';

class Nastaveni extends StatefulWidget{
  const Nastaveni({
    super.key,
    required this.toggleMode
    });

    final void Function() toggleMode;

  @override
  State<Nastaveni> createState() => _NastaveniState();
}

class _NastaveniState extends State<Nastaveni> {

  @override
  void initState(){
    super.initState();
    retrieveThemeMode();
  }

  String lang = languages[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: appBar(),
        body: settingsBody()
    );
  }

  Column settingsBody() {
    return Column(
        children: [
          darkModeSettings(),
          languageSettings(),
        ],
      );
  }

  Padding darkModeSettings() {
    return Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: darkModeRowTitle(),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: darkModeRowIcon(),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: darkModeRowSwitch(),
              ),
            ],
          ),
        );
  }

  Column darkModeRowTitle() {
    return Column(
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
    );
  }

  Column darkModeRowIcon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 5),
        Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode, size: 30),
      ],
    );
  }

  Column darkModeRowSwitch() {
    return Column(
      children: [
        Switch(value: isDarkMode,
        onChanged: (bool value) {
          setState(()
          {
            isDarkMode = value;
            widget.toggleMode();
          }
        );
        }),
      ],
    );
  }

  Padding languageSettings() {
    return Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: languageRowTitle(),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: languageRowIcon(),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: languageRowDropdown(),
              ),
            ],
          ),
        );
  }

  Column languageRowTitle() {
    return Column(
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
    );
  }

  Column languageRowIcon() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(height: 7),
        Icon(Icons.language, size: 30)
      ],
    );
  }

  Column languageRowDropdown() {
    return Column(
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
    );
  }
}