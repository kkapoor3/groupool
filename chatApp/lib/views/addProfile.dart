import 'package:chatapp/views/chatrooms.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/services/database.dart';

class AddProfile extends StatefulWidget{
  @override
  _AddProfileState createState() => _AddProfileState();

}

class _AddProfileState extends State<AddProfile>{

  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController sourceEditingController = new TextEditingController();
  TextEditingController destinationEditingController = new TextEditingController();
  TextEditingController sourceTimeEditingController = new TextEditingController();
  TextEditingController destinationTimeEditingController = new TextEditingController();

  DatabaseMethods databaseMethods = new DatabaseMethods();

  bool isLoading = false;

  addProfile() async{
    setState(() {

      isLoading = true;
    });

    Map<String,String> ProfileDataMap = {
      "email" : emailEditingController.text,
      "fullName" : nameEditingController.text,

    };

    databaseMethods.addProfileInfo(emailEditingController.text, ProfileDataMap);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatRoom()));

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        appBar: AppBar(title:Center(child: Text('Enter Details'))),
        backgroundColor: Colors.brown[900],
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(
                height: 26,
              ),
              TextFormField(
                style: simpleTextStyle(),
                controller: emailEditingController,
                validator: (val){
                  return val.isEmpty || val.length < 3 ? "Enter Name 3+ characters" : null;
                },
                decoration: textFieldInputDecoration("Confirm Email"),
              ),
              SizedBox(
                height: 26,
              ),
              TextFormField(
                style: simpleTextStyle(),
                controller: nameEditingController,
                validator: (val){
                  return val.isEmpty || val.length < 3 ? "Enter Name 3+ characters" : null;
                },
                decoration: textFieldInputDecoration("Full Name"),
              ),
              // SizedBox(
              //   height: 16,
              // ),
              // TextFormField(
              //   style: simpleTextStyle(),
              //   controller: sourceEditingController,
              //   validator: (val){
              //     return val.isEmpty || val.length < 3 ? "Enter Name 3+ characters" : null;
              //   },
              //   decoration: textFieldInputDecoration("Source Location"),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // TextFormField(
              //   style: simpleTextStyle(),
              //   controller: destinationEditingController,
              //   validator: (val){
              //     return val.isEmpty || val.length < 3 ? "Enter Name 3+ characters" : null;
              //   },
              //   decoration: textFieldInputDecoration("Destination Location"),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // TextFormField(
              //   style: simpleTextStyle(),
              //   controller: sourceTimeEditingController,
              //   validator: (val){
              //     return val.isEmpty || val.length < 3 ? "Enter Name 3+ characters" : null;
              //   },
              //   decoration: textFieldInputDecoration("Time at which you leave for work"),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // TextFormField(
              //   style: simpleTextStyle(),
              //   controller: destinationTimeEditingController,
              //   validator: (val){
              //     return val.isEmpty || val.length < 3 ? "Enter Name 3+ characters" : null;
              //   },
              //   decoration: textFieldInputDecoration("Time at which you leave for home"),
              // ),
              // SizedBox(
              //   height: 56,
              // ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: (){
                  addProfile();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [const Color(0xff3e2723), const Color(0xff4e342e)],
                      )),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Submit",
                    style: biggerTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}