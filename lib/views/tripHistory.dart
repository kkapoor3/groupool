
import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/allTrips.dart';
import 'package:chatapp/views/makeATrip.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class tripHistory extends StatefulWidget {
  @override

  _tripHistoryState createState() => _tripHistoryState();
}

class _tripHistoryState extends State<tripHistory> {
  Stream<QuerySnapshot> trips;
  Widget ListOfTrips() {
    return StreamBuilder(
      stream: trips,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              //return Text(snapshot.data.documents[index].data["nameOfTheTrip"]);
              return Card(
                color:Colors.brown,
                child: Column(
                  children: [
                    Text(snapshot.data.documents[index].data["nameOfTheTrip"],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    Text(snapshot.data.documents[index].data["Source"]+" to "+snapshot.data.documents[index].data["Destination"],

                        style:TextStyle(fontWeight:FontWeight.bold,color: Colors.grey)),

                   Text(snapshot.data.documents[index].data["from"]+" to "+snapshot.data.documents[index].data["untill"],
                      style: TextStyle(fontSize: 20),),
                  ],
                ),
              );
            })
            : Container(
            child:Text("No trips")
        );
      },
    );
  }
  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }
  @override
  void initState() {
    DatabaseMethods().getTrips(Constants.myName).then((val) {
      setState(() {
        trips = val;
        print(trips);
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Trips'),
        backgroundColor: Colors.brown[900],
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => allTrips()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Icon(Icons.airport_shuttle_outlined),
                  SizedBox(width: 10,),
                  Text("All Trips",style: simpleTextStyle(),),
                ],
              ),
            ),
          ),

        ],
      ),
      body: ListOfTrips(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => makeATrip()));
        },
      ),
    );
  }
}
