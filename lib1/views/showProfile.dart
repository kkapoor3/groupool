import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chat.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addProfile.dart';

class ShowProfile extends StatefulWidget {
  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  //Stream userProfile;
  QuerySnapshot email;

  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isLoading = false;
  
  setEmail() async{
    Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    await databaseMethods.getProfileInfo(Constants.myEmail)
          .then((snapshot){
        setState(() {
          email=snapshot;
        });
        print(snapshot);
        print(email.documents[0].data['email']);
      });
  }

  @override
  void initState()  {
    setEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          elevation: 0.0,
          centerTitle: false,
          actions: [
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddProfile()));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.edit),
              ),
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 100, vertical: 100),
          child: Center(
            child:Column(
              children: [
                Row(
                  children: [
                    Text("Full Name:",style: simpleTextStyle(), textAlign: TextAlign.center),
                    SizedBox(width: 10,),
                    Text(email.documents[0].data['fullName'],style: simpleTextStyle(), textAlign: TextAlign.center),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Row(
                  children: [
                    Text("Email:",style: simpleTextStyle(),),
                    SizedBox(width: 10,),
                    Text(email.documents[0].data['email'],style: simpleTextStyle(),),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Row(
                  children: [
                    Text("Source:",style: simpleTextStyle(),),
                    SizedBox(width: 10,),
                    Text(email.documents[0].data['source'],style: simpleTextStyle(),),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Row(
                  children: [
                    Text("Destination:",style: simpleTextStyle(),),
                    SizedBox(width: 10,),
                    Text(email.documents[0].data['destination'],style: simpleTextStyle(),),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Row(
                  children: [
                    Text("Time to leave for work:",style: simpleTextStyle(),),
                    SizedBox(width: 10,),
                    Text(email.documents[0].data['sourceTime'],style: simpleTextStyle(),),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Row(
                  children: [
                    Text("Time to go home:",style: simpleTextStyle(),),
                    SizedBox(width: 10,),
                    Text(email.documents[0].data['destinationTime'],style: simpleTextStyle(),),
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}


