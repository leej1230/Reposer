import 'package:flutter/material.dart';
import 'package:reposer/components/textStyleComponents.dart';
import 'package:reposer/sessionChoice.dart';
import 'entities/addSongsToDB.dart';
import 'sessionChoice.dart';
import './components/textStyleComponents.dart';

void main() {
  // TODO add if statement to check whether the db already exists or not
  // Function for initialize db if needed
  runApp(const MyApp());
  addSongsToDB();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome Back',
                // Consider making this style constant for later development
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
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
                  title: 'Start Session',
                  titleSize: 22.0),
              // TextButton(
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return SessionChoiceScreen();
              //     }));
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(
              //       vertical: 3.0,
              //       horizontal: 14.0,
              //     ),
              //     child: Text(
              //       'Start Session',
              //       style: TextStyle(
              //         fontSize: 22.0,
              //         color: Colors.white,
              //         fontWeight: FontWeight.w800,
              //       ),
              //     ),
              //   ),
              //   style: TextButton.styleFrom(
              //     foregroundColor: Colors.white,
              //     backgroundColor: Colors.white.withOpacity(0.2),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
