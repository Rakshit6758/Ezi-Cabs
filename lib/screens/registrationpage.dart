import 'package:connectivity/connectivity.dart';
import 'package:ezi_cabs/brand_colors.dart';
import 'package:ezi_cabs/screens/loginpage.dart';
import 'package:ezi_cabs/widgets/ProgressDialog.dart';
import 'package:ezi_cabs/widgets/TaxiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ezi_cabs/screens/mainpage.dart';

class RegistrationPage extends StatefulWidget {

  static const String id = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),
    );
    scaffoldkey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  void registerUser() async{

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Registering...',),
    );

    final User user =(await _auth.createUserWithEmailAndPassword(
        email: emailController.text ,
        password: passwordController.text,
    ).catchError((ex){
      // check error and display message
      Navigator.pop(context);
      PlatformException thisEx = ex;
      showSnackBar(thisEx.message);


    })).user;

    Navigator.pop(context);
    if(user != null){
      DatabaseReference newUserRef = FirebaseDatabase.instance.reference().child('users/${user.uid}');

      // Prepare data to be saved
      Map userMap = {
        'fullname': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      };

      newUserRef.set(userMap);

      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
    }


    // try {
    //   UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: emailController.text,
    //       password: passwordController.text,
    //   );
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'weak-password') {
    //     print('The password provided is too weak.');
    //   } else if (e.code == 'email-already-in-use') {
    //     print('The account already exists for that email.');
    //   }
    // } catch (e) {
    //   print(e);
    // }
    // User user = FirebaseAuth.instance.currentUser;
    // if (!user.emailVerified) {
    //   await user.sendEmailVerification();
    // }

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
                    SizedBox(height: 30,),
                    Image(
                      alignment: Alignment.center,
                      height: 200.0,
                      width: 200.0,
                      image: AssetImage('images/Ezi.png'),
                    ),

                    SizedBox(height: 10,),

                    Text('Create Account',
                      textAlign: TextAlign.center,

                      style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold', color: Colors.white),
                    ),

                    SizedBox(height: 10,),

                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                            // full name
                          TextField(
                            controller: fullNameController,
                            cursorColor: BrandColors.colorMustard,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: 'Full Name',
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
                          // email
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
                          // phone number
                          TextField(
                            controller: phoneController,
                            cursorColor: BrandColors.colorMustard,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                labelText: 'Phone Number',
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
                          // password
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
                            title: 'REGISTER',
                            color: BrandColors.colorMustard,
                            onPressed:() async{

                              var connectivityResult = await Connectivity().checkConnectivity();
                              if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
                                showSnackBar('No Internet connectivity');
                                return;
                              }

                              if(fullNameController.text.length <3){
                                showSnackBar('Please provide a valid Full Name');
                                return;
                              }

                              if(!emailController.text.contains('@')){
                                showSnackBar('Please provide a valid email address');
                                return;
                              }

                              if(phoneController.text.length < 10){
                                showSnackBar('Please provide a valid phone number');
                                return;
                              }

                              if(passwordController.text.length < 8){
                                showSnackBar('password must be at least 8 characters ');
                                return;
                              }


                              registerUser();
                            },
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: 5.0,),

                    FlatButton(
                      onPressed: (){
                        Navigator.pushNamedAndRemoveUntil(context, LoginPage.id, (route) => false);
                      },
                      child: Text('Already have an account, Log in',
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


