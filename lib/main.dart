import 'package:flutter/material.dart';
import 'package:reposer/components/textStyleComponents.dart';
import 'package:reposer/sessionChoice.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'entities/addSongsToDB.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sessionChoice.dart';
import './components/textStyleComponents.dart';

void main() {
  runApp(const MyApp());
  // Function for initialize db if needed
  addSongsToDB();
}

// var defaultLang = Locale('en');

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reposer',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      localizationsDelegates: LangLocal.localizationsDelegates,
      supportedLocales: LangLocal.supportedLocales,
      // locale: defaultLang,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(-0.9, -1.0),
            image: AssetImage('assets/images/background/10.jpg'),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      // 'Welcome Back',
                      LangLocal.of(context)!.welcome_back,
                      // Consider making this style constant for later development
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TransparentTitle(
                      pressedAction: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SessionChoiceScreen();
                        }));
                      },
                      // title: 'Start Session',
                      title: LangLocal.of(context)!.start_session,
                      titleSize: 22.0),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CreditButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditButton extends StatefulWidget {
  const CreditButton({Key? key}) : super(key: key);

  @override
  State<CreditButton> createState() => _CreditButtonState();
}

class _CreditButtonState extends State<CreditButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        AwesomeDialog(
          context: context,
          animType: AnimType.bottomSlide,
          dialogType: DialogType.noHeader,
          title: 'Credits',
          body: Column(
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Credit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('Idea Proposer: Nao Nagashima'),
              ),
              SizedBox(
                height: 5,
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('Programmer: Jaewoo Lee'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.linkedin,
                    ),
                    onPressed: () async {
                      const url = 'https://www.linkedin.com/in/jaewoolee1230/';
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                    ),
                    onPressed: () async {
                      const url = 'https://github.com/leej1230';
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                  ),
                ],
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('Additional contributor: Chino Domitsu'),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Attribution',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                onTap: () async {
                  const url =
                      'https://github.com/leej1230/Reposer/blob/master/lib/attribution.md';
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
              SizedBox(
                height: 5,
              ),
              InkWell(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'Project Repository',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                onTap: () async {
                  const url = 'https://github.com/leej1230/Reposer';
                  if (await canLaunchUrlString(url)) {
                    await launchUrlString(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
              ),
            ],
          ),
          btnOkText: 'Done',
          btnOkOnPress: () {},
        )..show();
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(10.0)),
        child: Text(
          'Credits・クレジット表記',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
