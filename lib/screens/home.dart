import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firechat/screens/login_screen.dart';
import 'package:firechat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static String id = 'home.dart';
 
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 var colorizeColors = [
  Colors.red,
  Colors.orange,
  Colors.red.shade900,
  Colors.red.shade500,
];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: Hero(
                  tag: 'logo',
                  child: Image(
                    image: AssetImage(
                      'assets/firechat.png',
                    ),
                    height: 50,
                    width: 50,
                    colorBlendMode: BlendMode.softLight,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: Text('Fire',style:  GoogleFonts.getFont('Acme',textStyle:TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)),)
                
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:16.0),
                child: AnimatedTextKit(animatedTexts: [
                   ColorizeAnimatedText(
                  'Chat',
                  textStyle: GoogleFonts.getFont('Acme',textStyle:TextStyle(fontSize: 30, fontWeight: FontWeight.bold,)),
                   colors: colorizeColors,                     
                ),
                ],
                isRepeatingAnimation: true,)
              ),
            ],
          ),
         Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0),),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                  Navigator.pushNamed(context, LoginPage.id);
                });
                  },
                  minWidth: size.width * 0.9,
                  height: size.height * 0.08,
                  child: Text(
                    'Login',
                    style:  GoogleFonts.getFont('Paytone One',textStyle:TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                ),
              ),
            ),
         Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                });
                  },
                  minWidth: size.width * 0.9,
                  height: size.height * 0.08,
                  child: Text(
                    'Register',
                    style:  GoogleFonts.getFont('Paytone One',textStyle:TextStyle(fontSize: 20,color: Colors.white)),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
