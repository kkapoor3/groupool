import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/chat.dart';
import 'package:chatapp/views/makeATrip.dart';
import 'package:chatapp/views/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Commutes extends StatefulWidget {

  @override

  _CommutesState createState() => _CommutesState();
}

class _CommutesState extends State<Commutes> {
  Stream<QuerySnapshot> commutes;
  Widget ListOfTrips() {
    return StreamBuilder(
      stream: commutes,
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(28, 0, 100, 0),
                      child: Row(
                        children: [
                          Icon(Icons.home),
                          Text(snapshot.data.documents[index].data["home"]),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.work),
                          Text(snapshot.data.documents[index].data["work"])
                        ],
                      ),
                    ),
                    Text("Leaving: "+snapshot.data.documents[index].data["leavingTime"]+" Arrriving: "+snapshot.data.documents[index].data["arrivingTime"],
                      style: TextStyle(fontSize: 20),),
                    snapshot.data.documents[index].data["user"]!=Constants.myName?FlatButton(
                      color: Colors.brown[900],
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
            child:Text("No Commutes")
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
    DatabaseMethods().getAllProfiles().then((val) {
      setState(() {
        commutes = val;
        print(commutes);
      });
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Commutes'),
        backgroundColor: Colors.brown[900],
      ),
      body: ListOfTrips(),
    );
  }
}
