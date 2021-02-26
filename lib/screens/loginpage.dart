import 'package:ezi_cabs/brand_colors.dart';
import 'package:ezi_cabs/screens/registrationpage.dart';
import 'package:ezi_cabs/widgets/TaxiButton.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'login';
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
                        onPressed:(){ },
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


