import 'dart:math';

import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/models/user.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chat.dart';
import 'package:chatapp/views/team.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AddPeople extends StatefulWidget {
  final String projectId;
  final List<dynamic> people;
  final List<dynamic> usersCount;
  AddPeople({this.projectId, this.people,this.usersCount});
  @override
  _AddPeopleState createState() => _AddPeopleState();
}

class _AddPeopleState extends State<AddPeople> {

  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();
  QuerySnapshot searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;
  bool isAdded=false;

  initiateSearch() async {
    if(searchEditingController.text.isNotEmpty){
      setState(() {
        isLoading = true;
      });
      await databaseMethods.searchByName(searchEditingController.text)
          .then((snapshot){
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          haveUserSearched = true;
        });
      });
    }
  }

  Widget userList(){

    return haveUserSearched ? ListView.builder(
        shrinkWrap: true,
        itemCount: searchResultSnapshot.documents.length,
        itemBuilder: (context, index){
          return userTile(
            searchResultSnapshot.documents[index].data["userName"],
            searchResultSnapshot.documents[index].data["userEmail"],
          );
        }) : Container();
  }
  addToList(String userName){
    setState(() {
      if(!widget.people.contains(userName)){
        widget.people.add(userName);
        widget.usersCount.add(0);
      }
    });
  }

  addUser(){
    setState(() {
      isAdded=false;
    });
  }


  updateList() async{
    if(widget.people.length!=1) {

      await Firestore.instance.collection("projectRoom").document(widget.projectId).updateData({
        "users": widget.people}
      );
      await Firestore.instance.collection("projectRoom").document(widget.projectId).updateData({
        "usersCount": widget.usersCount}
      );

      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) =>
              Team(
                projectId: widget.projectId,
              )
      ));
    }

  }

  Widget userTile(String userName,String userEmail){
    //addUser();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
              Text(
                userEmail,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              )
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              addToList(userName);
              setState(() {
                isAdded=true;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 8),
              decoration: BoxDecoration(
                  color: isAdded ? Colors.brown : Colors.orange ,
                  borderRadius: BorderRadius.circular(24)
              ),
              child: isAdded ? Text("Added",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),):Text("Add",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),),
            ),
          ),

        ],
      ),
    );
  }
  String getProjectId(){
    var random = Random.secure();
    var value = random.nextInt(1000000);
    return "Project "+value.toString();

  }




  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add People'),
        backgroundColor: Colors.brown[900],
        actions: [
          GestureDetector(
            onTap: (){
              updateList();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.add),
            ),
          ),

        ],
      ),
      body: isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) :  Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              color: Color(0x54FFFFFF),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(

                      controller: searchEditingController,
                      style: simpleTextStyle(),
                      decoration: InputDecoration(
                          hintText: "Add User ...",
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                      addUser();
                    },
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  const Color(0x36FFFFFF),
                                  const Color(0x0FFFFFFF)
                                ],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight
                            ),
                            borderRadius: BorderRadius.circular(40)
                        ),
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/images/search_white.png",
                          height: 25, width: 25,)),
                  ),

                ],
              ),
            ),
            userList()
          ],
        ),
      ),
    );
  }
}


