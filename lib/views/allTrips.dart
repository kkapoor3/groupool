import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chat.dart';
import 'package:chatapp/views/makeATrip.dart';
import 'package:chatapp/views/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class allTrips extends StatefulWidget {

  @override

  _allTripsState createState() => _allTripsState();
}

class _allTripsState extends State<allTrips> {
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
                color: Colors.brown,
                child: Column(
                  children: [
                    Text(snapshot.data.documents[index].data["user"],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    Text(snapshot.data.documents[index].data["nameOfTheTrip"],
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    Text(snapshot.data.documents[index].data["Source"]+" to "+snapshot.data.documents[index].data["Destination"],
                        style:TextStyle(fontWeight:FontWeight.bold)),
                    Text(snapshot.data.documents[index].data["from"]+" to "+snapshot.data.documents[index].data["untill"],
                      style: TextStyle(fontSize: 20),),
                    snapshot.data.documents[index].data["user"]!=Constants.myName?FlatButton(
                      color:Colors.brown[900],
                      onPressed: () {
                        // Perform some action
                        sendMessage(snapshot.data.documents[index].data["user"]);
                      },
                      child: const Text('Message',style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold),),

                    ):Container(),
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
  sendMessage(String userName){

    List<String> users = [Constants.myName,userName];

    String chatRoomId = getChatRoomId(Constants.myName,userName);

    Map<String, dynamic> chatRoom = {
      "users": users,
      "chatRoomId" : chatRoomId,
    };

    DatabaseMethods().addChatRoom(chatRoom, chatRoomId);

    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Chat(
          chatRoomId: chatRoomId,
        )
    ));

  }
  @override
  void initState() {
    DatabaseMethods().getAllTrips().then((val) {
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
        title: Text('All Trips'),
          backgroundColor: Colors.brown[900],
      ),
    body: ListOfTrips(),
    );
  }
}
