import 'dart:async';

import 'package:ezi_cabs/brand_colors.dart';
import 'package:ezi_cabs/screens/searchpage.dart';
import 'package:ezi_cabs/styles/styles.dart';
import 'package:ezi_cabs/widgets/BrandDivider.dart';
import 'package:ezi_cabs/widgets/TaxiButton.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController mapController;
  double mapBottomPadding = 0;

  var geoLocator = Geolocator();
  Position currentPosition;

  void setupPositionLocator() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = new CameraPosition(target: pos, zoom: 14);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: Container(
        width: 250,
        color: Colors.white,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[

              Container(
                color: BrandColors.colorMustard,
                height: 180,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.black
                  ),
                  child: Row(
                    children: <Widget>[
                      Image.asset('images/user_icon.png', height: 60, width: 60,),
                      SizedBox(width: 15,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Rakshit Kapoor", style: TextStyle(fontSize: 20, fontFamily: 'Brand-Bold',color: BrandColors.colorMustard),),
                          SizedBox(height: 5,),
                          Text('View Profile', style: TextStyle(color: Colors.white),),
                        ],
                      )
                    ],
                  )

                ),
              ),
              BrandDivider(),

              SizedBox(height: 10,),

              ListTile(
                leading: Icon(OMIcons.cardGiftcard, color: Colors.black,),
                title: Text('Free Ride', style: kDrawerItemStyle,),
              ),

              ListTile(
                leading: Icon(OMIcons.creditCard, color: Colors.black,),
                title: Text('Payments', style: kDrawerItemStyle,),
              ),

              ListTile(
                leading: Icon(OMIcons.history, color: Colors.black),
                title: Text('Ride History', style: kDrawerItemStyle,),
              ),

              ListTile(
                leading: Icon(OMIcons.contactSupport, color: Colors.black),
                title: Text('Support', style: kDrawerItemStyle,),
              ),

              ListTile(
                leading: Icon(OMIcons.info, color: Colors.black),
                title: Text('About', style: kDrawerItemStyle,),
              ),

            ],
          ),

        ),

      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapBottomPadding),
            mapType: MapType.normal ,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
              mapController = controller;

              setState(() {
                mapBottomPadding = 310;
              });


              setupPositionLocator();



            },

          ),

          ///Menu Button
          Positioned(
            top: 44,
            left: 20,
            child: GestureDetector(
              onTap: (){
                scaffoldkey.currentState.openDrawer();

              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        0.7,
                        0.7,
                      )
                    )
                  ]
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.black,
                  radius: 20,
                  child: Icon(Icons.menu, color: BrandColors.colorMustard ,),
                ),

              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom:0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 15.0,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7,
                    )
                  )
                ]

              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 5,),
                    Text('Nice to see you', style: TextStyle(fontSize: 12, color: Colors.white),),
                    Text('Where are you going?', style: TextStyle(fontSize: 20, fontFamily: 'Brand-Bold', color: BrandColors.colorMustard),),

                    SizedBox(height: 20,),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SearchPage()
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 5.0,
                              spreadRadius: 0.3,
                              offset: Offset(
                                0.7,
                                0.7,
                              )
                            )
                          ]
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.search, color: BrandColors.colorMustard,),
                              SizedBox(width: 10,),
                              Text('Search Destination', style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 25,),

                    Row(
                      children: <Widget>[
                        Icon(OMIcons.home, color: BrandColors.colorMustard,),
                        SizedBox(width: 12,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Add Home',style: TextStyle(color: Colors.white),),
                            SizedBox(height: 3, ),
                            Text('Your residential address',
                                style: TextStyle(fontSize: 11, color: BrandColors.colorDimText,),
                            )
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 15,),

                    BrandDivider(),

                    SizedBox(height: 15,),

                    Row(
                      children: <Widget>[
                        Icon(OMIcons.workOutline, color: BrandColors.colorMustard,),
                        SizedBox(width: 12,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Add Work',style: TextStyle(color: Colors.white),),
                            SizedBox(height: 3,),
                            Text('Your Office Address',
                              style: TextStyle(fontSize: 11, color: BrandColors.colorDimText ,),
                            )
                          ],
                        )
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),

          //Ride Datails
          Positioned(
            left: 0,
            right:0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular((15))),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(
                          0.7,
                          0.7,
                        )
                    )
                  ],
              ),
              height:0,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: <Widget>[
                            Image.asset('images/taxi.png', height:70, width: 70,),
                            SizedBox(width: 16,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text('Taxi', style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),),
                                Text('14Km', style: TextStyle(fontSize: 16, color: BrandColors.colorTextLight),),
                              ]
                            ),
                            Expanded(child: Container()),
                            Text('\$13', style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 22,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: <Widget>[

                          Icon(FontAwesomeIcons.moneyBillAlt, size:18, color: Colors.white,),
                          SizedBox(width: 16,),
                          Text('Cash', style: TextStyle(color: Colors.white),),
                          SizedBox(width: 5,),
                          Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 16),

                        ],
                      ),
                    ),

                    SizedBox(height: 22,),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: TaxiButton(
                        title: 'REQUEST CAB',
                        color: BrandColors.colorMustard,
                        onPressed: (){

                        },
                      ),
                    )
                  ],
                ),
              ),

            ),
          )


        ],
      )
    );
  }
}
