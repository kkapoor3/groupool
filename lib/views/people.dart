import 'dart:io';

import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/addPeople.dart';
import 'package:chatapp/views/team.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class People extends StatefulWidget {
  final String projectId;
  People({this.projectId});
  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  QuerySnapshot doc;
  bool haveSearched = false;
  String admin;
  bool isAdmin = false;
  List<dynamic> pplList;
  List<dynamic> counts;
  int counter=0;
  int prev;
  getDoc() async {
    await DatabaseMethods().getUsers(widget.projectId).then((snapshot) {
      setState(() {
        doc = snapshot;
        haveSearched = true;
        admin = doc.documents[0].data["admin"];
        isAdmin = (Constants.myName == admin);
        print(isAdmin);
        counts=doc.documents[0].data['usersCount'];
      });
    });
    print("Hello");
  }

  void increaseCount(index){
    setState(() {
      counts[index]+=1;
    });
    print(counts);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoc();
  }

  Widget counterInc(){
    return Container(
      child:Column(
        children: [
          Text(counter.toString(),style: simpleTextStyle(),),
          ElevatedButton.icon(
              onPressed: () {
                // Respond to button press
                setState(() {
                  counter=counter+1;
                });
              },
              icon: Icon(Icons.add, size: 18),
              label: Text("add"),
              style:ElevatedButton.styleFrom(primary: Colors.brown[800])
          ),

        ],
      )
    );
  }

  Widget userList() {
    return haveSearched
        ? userTile(
            doc.documents[0].data["users"],
          )
        : Container(
            child: Center(
            child: Text(
              "Loading! Please wait...",
              style: TextStyle(color: Colors.white, fontSize: 30.0),
            ),
          ));
  }


  Widget userTile(List<dynamic> people) {
    print(people.runtimeType);
    setState(() {
      pplList = people;
    });

    print(pplList);

    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: people.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                height: 50,
                child: Card(
                  color: Colors.black12,
                  child: InkWell(
                    onTap: () {
                      print('Card tapped.');
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: Colors.brown,
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(people[index].substring(0, 1),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'OverpassRegular',
                                  fontWeight: FontWeight.w300)),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Row(
                          children: [
                            (Constants.myName==people[index])?Text("You",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'OverpassRegular',
                                    fontWeight: FontWeight.w300)):
                            Text(people[index],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'OverpassRegular',
                                    fontWeight: FontWeight.w300)),
                            SizedBox(width: 10.0,),
                            (admin==people[index])? Icon(Icons.person,
                              color: Colors.white,):Text(''),

                            Text(counts[index].toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'OverpassRegular',
                                    fontWeight: FontWeight.w300)),
                            SizedBox(width: 20.0,),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Respond to button press
                                increaseCount(index);
                              },
                              icon: Icon(Icons.add, size: 10),
                              label: Text("add"),
                              style:ElevatedButton.styleFrom(primary: Colors.brown[800])
                            ),
                            SizedBox(width: 10.0,),
                            ElevatedButton.icon(
                                onPressed: () {
                                  // Respond to button press
                                  increaseCount(index);
                                },
                                icon: Icon(Icons.remove, size: 10),
                                label: Text("undo"),
                                style:ElevatedButton.styleFrom(primary: Colors.brown[800])
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //counterInc(),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People with ride count'),
        backgroundColor: Colors.brown[900],
        actions: [
          isAdmin
              ? GestureDetector(
                  onTap: () {
                    print(Constants.myName);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPeople(
                                projectId: widget.projectId, people: pplList,usersCount:counts)));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(Icons.group_add),
                  ),
                )
              : SizedBox(height: 0.0,width: 0.0,),
        ],
      ),
      body: userList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.update),
          onPressed: () async {
            await Firestore.instance.collection("projectRoom").document(widget.projectId).updateData({
              "usersCount": counts}
            );
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Team(projectId:widget.projectId)));

          },
        )
    );
  }
}
