import 'package:connectivity/connectivity.dart';
import 'package:ezi_cabs/brand_colors.dart';
import 'package:ezi_cabs/screens/mainpage.dart';
import 'package:ezi_cabs/screens/registrationpage.dart';
import 'package:ezi_cabs/widgets/TaxiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
    );
    scaffoldkey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void login() async{

    final User user =(await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
    ).catchError((ex){

      PlatformException thisEx = ex;
      showSnackBar(thisEx.message);
    })).user;

    if(user != null){
      // verify login
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users/${user.uid}');
      userRef.once().then((DataSnapshot snapshot){
        if (snapshot.value != null){
          Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);

        }
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40,),
                Image(
                  alignment: Alignment.center,
                  height: 200.0,
                  width: 200.0,
                  image: AssetImage('images/Ezi.png'),
                ),

                 SizedBox(height: 30,),

                Text('Sign In',
                textAlign: TextAlign.center,

                style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold', color: Colors.white),
                ),

                SizedBox(height: 20,),

                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        cursorColor: BrandColors.colorMustard,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: 'Email address',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14, color: BrandColors.colorMustard) ,
                      ),

                      SizedBox(height: 15.0,),

                      TextField(
                        controller: passwordController,
                        cursorColor: BrandColors.colorMustard,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white
                            ),
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10.0
                            )
                        ),
                        style: TextStyle(fontSize: 14, color: BrandColors.colorMustard) ,
                      ),

                      SizedBox(height: 50.0,),

                      TaxiButton(
                        title: 'LOGIN',
                        color: BrandColors.colorMustard,
                        onPressed:() async {

                          var connectivityResult = await Connectivity().checkConnectivity();
                          if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
                            showSnackBar('No Internet connectivity');
                            return;
                          }

                          if(!emailController.text.contains('@')){
                            showSnackBar('Please enter a valid email address');
                            return;
                          }

                          if(passwordController.text.length < 8){
                            showSnackBar('Please enter a valid password');
                            return;
                          }

                          login();

                        },
                      )
                    ],
                  ),
                ),

                SizedBox(height: 10.0,),

                FlatButton(
                  onPressed: (){
                    Navigator.pushNamedAndRemoveUntil(context, RegistrationPage.id, (route) => false);
                  },
                    child: Text('Don\'t have an account, sign up here',
                    style: TextStyle(
                      color: BrandColors.colorMustard
                    ),
                    ),

                ),








              ]
            ),
          ),
        ),
      )
    );
  }
}


