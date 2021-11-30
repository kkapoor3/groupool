import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chat.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowProfile extends StatefulWidget {
  @override
  _ShowProfileState createState() => _ShowProfileState();
}

class _ShowProfileState extends State<ShowProfile> {
  //Stream userProfile;
  QuerySnapshot email;

  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isLoading = false;
  String fullName;

  String Email;



  setEmail() async{
    Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    await databaseMethods.getProfileInfo(Constants.myEmail)
        .then((snapshot){
      setState(() {
        email=snapshot;

      });
      setState(() {
        fullName=email.documents[0].data['fullName'];
        Email=email.documents[0].data['email'];
        print("Hello");
      });

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
          backgroundColor: Colors.brown[900],
          elevation: 0.0,
          centerTitle: false,
          actions: [],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Center(
              child:Column(
                children: [
                  Row(
                    children: [
                      Text("Full Name:",style: simpleTextStyle(),),
                      SizedBox(width: 10,),
                      Text(fullName??'loading',style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("UserName:",style: simpleTextStyle(),),
                      SizedBox(width: 10,),
                      Text(Constants.myName,style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Email:",style: simpleTextStyle(),),
                      SizedBox(width: 10,),
                      Text(Email??'loading',style: simpleTextStyle(),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}


