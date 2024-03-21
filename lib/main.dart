import 'package:firechat/screens/chat_screen.dart';
import 'package:firechat/screens/home.dart';
import 'package:firechat/screens/login_screen.dart';
import 'package:firechat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

 final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: ThemeData.dark(),
     home: FutureBuilder(
       future: _fbApp,
       builder: (context,snapshot){
         if(snapshot.hasError){
           return Text('Something went wrong!');
         }
         else if(snapshot.hasData){
           print('FireBase initialised successfully');
           return HomePage();
         }
         else{
           return Center(
             child: CircularProgressIndicator(),
           );
         }
       },
     ),
     initialRoute: HomePage.id,
     routes: {
       HomePage.id:(context)=>HomePage(),
       LoginPage.id:(context)=>LoginPage(),
       RegistrationScreen.id:(context)=> RegistrationScreen(),
       ChatScreen.id:(context)=> ChatScreen()
     },
    );
  } 
}

