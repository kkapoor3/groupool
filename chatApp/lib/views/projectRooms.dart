import 'package:chatapp/helper/authenticate.dart';
import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/helper/helperfunctions.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/views/team.dart';
import 'package:chatapp/helper/theme.dart';
import 'package:chatapp/views/search2.dart';

class ProjectRooms extends StatefulWidget {


  @override
  _ProjectRoomsState createState() => _ProjectRoomsState();
}

class _ProjectRoomsState extends State<ProjectRooms> {
  Stream projectRooms;

  Widget projectRoomList(){
    return StreamBuilder(
      stream: projectRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            reverse: true,
            itemCount: snapshot.data.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ProjectTile(

                projectId: snapshot.data.documents[index].data["projectId"],
              );
            })
            : Container();
      }
    );

  }
  @override
  void initState() {
    getUserInfogetChats();

    super.initState();
  }

  getUserInfogetChats() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    DatabaseMethods().getUserChats2(Constants.myName).then((snapshots) {
      setState(() {
        projectRooms = snapshots;
        print(
            "we got the data + ${projectRooms.toString()} this is name  ${Constants.myName}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Chat Rooms"),
            backgroundColor: Colors.brown[900],
            elevation: 0.0,
            centerTitle: false,
            actions: [
          GestureDetector(
            onTap: () {
              AuthService().signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          ),
        ]),
            body: Container(
              child: projectRoomList(),

    ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search2()));
        },
      ),
    );
  }
}

class ProjectTile extends StatefulWidget {
  final String projectId;
  ProjectTile({this.projectId});

  @override
  _ProjectTileState createState() => _ProjectTileState();
}

class _ProjectTileState extends State<ProjectTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Team(
                      projectId: widget.projectId,
                    )));
      },
      child: Container(
        color: Colors.black26,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 2.0, 4.0, 3.0),
                child: Text(widget.projectId.substring(8, 10),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300)),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Text(widget.projectId,
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'OverpassRegular',
                    fontWeight: FontWeight.w300)),
          ],
        ),
      ),
    );
  }
}
