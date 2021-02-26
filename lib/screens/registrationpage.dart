import 'package:ezi_cabs/brand_colors.dart';
import 'package:ezi_cabs/screens/loginpage.dart';
import 'package:ezi_cabs/widgets/TaxiButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {

  static const String id = 'register';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  void registerUser() async{
    final User user = (await _auth.createUserWithEmailAndPassword(
        email: 'an email',
        password: 'a password',
    )).user;

    if(user != null){
      print('registration successful');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            onPressed:(){
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


