import 'package:ezi_cabs/brand_colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  var pickupController = TextEditingController();
  var destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // String address = Provider.of<AppData>(context).pickupAddress.placeName ?? '';
    // pickupController.text = address;

    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
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
              padding: EdgeInsets.only(left: 24, top: 40, right: 24, bottom: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 25,),
                  Stack(
                    children: <Widget>[
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)),
                      Center(
                        child: Text('Set Destination',
                        style: TextStyle(fontSize: 20, fontFamily: 'Brand-Bold')),
                      )
                    ],
                  ),

                  SizedBox(height: 20,),

                  Row(
                    children: <Widget>[
                      Image.asset('images/pickicon.png',height: 16, width: 16),

                      SizedBox(width: 18,),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: BrandColors.colorLightGrayFair,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: TextField(
                              controller: pickupController,
                              decoration: InputDecoration(
                                hintText: 'Pickup Location',
                                fillColor: BrandColors.colorLightGrayFair,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10,),

                  Row(
                    children: <Widget>[
                      Image.asset('images/desticon.png',height: 16, width: 16),

                      SizedBox(width: 18,),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: BrandColors.colorLightGrayFair,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0),
                            child: TextField(
                              controller: destinationController,
                              decoration: InputDecoration(
                                hintText: 'Where to ?',
                                fillColor: BrandColors.colorLightGrayFair,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),


                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
