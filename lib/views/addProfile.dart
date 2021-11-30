import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/views/chatrooms.dart';
import 'package:chatapp/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/services/database.dart';

class AddProfile extends StatefulWidget {
  final String user;
  //final String otheruser;

  AddProfile({this.user});

  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController sourceEditingController = new TextEditingController();
  TextEditingController destinationEditingController =
      new TextEditingController();
  TextEditingController sourceTimeEditingController =
      new TextEditingController();
  TextEditingController destinationTimeEditingController =
      new TextEditingController();

  DatabaseMethods databaseMethods = new DatabaseMethods();

  bool isLoading = false;

  addProfile() async {
    setState(() {
      isLoading = true;
    });

    Map<String, String> ProfileDataMap = {
      "user": widget.user,
      "email": emailEditingController.text,
      "fullName": nameEditingController.text,
      "home": sourceEditingController.text,
      "work": destinationEditingController.text,
      "leavingTime": _time.format(context),
      "arrivingTime": _time2.format(context),
    };

    databaseMethods.addProfileInfo(emailEditingController.text, ProfileDataMap);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ChatRoom()));
  }

  TimeOfDay _time = TimeOfDay(hour: 6, minute: 15);
  TimeOfDay _time2 = TimeOfDay(hour: 8, minute: 15);

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
    print(_time.format(context));
    print(widget.user);
  }

  void _selecTime2() async {
    final TimeOfDay newTime2 = await showTimePicker(
      context: context,
      initialTime: _time2,
    );
    if (newTime2 != null) {
      setState(() {
        _time2 = newTime2;
      });
    }
    print(_time2.format(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Enter Details')),
          backgroundColor: Colors.brown[900],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(
                  height: 26,
                ),
                TextFormField(
                  key: new Key('emailKey'),
                  style: simpleTextStyle(),
                  controller: emailEditingController,
                  validator: (val) {
                    return val.isEmpty || val.length < 3
                        ? "Enter Name 3+ characters"
                        : null;
                  },
                  decoration: textFieldInputDecoration("Confirm Email"),
                ),
                SizedBox(
                  height: 26,
                ),
                TextFormField(
                  key: new Key('nameKey'),
                  style: simpleTextStyle(),
                  controller: nameEditingController,
                  validator: (val) {
                    return val.isEmpty || val.length < 3
                        ? "Enter Name 3+ characters"
                        : null;
                  },
                  decoration: textFieldInputDecoration("Full Name"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  key: new Key('sourceKey'),
                  style: simpleTextStyle(),
                  controller: sourceEditingController,
                  validator: (val) {
                    return val.isEmpty || val.length < 3
                        ? "Enter Name 3+ characters"
                        : null;
                  },
                  decoration: textFieldInputDecoration("Home Location"),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  key: new Key('destKey'),
                  style: simpleTextStyle(),
                  controller: destinationEditingController,
                  validator: (val) {
                    return val.isEmpty || val.length < 3
                        ? "Enter Name 3+ characters"
                        : null;
                  },
                  decoration: textFieldInputDecoration("Work Location"),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.brown[800]),
                  onPressed: _selectTime,
                  child: Text('select the time you leave for Work'),
                ),
                SizedBox(height: 15),
                Text(
                  'Selected time: ${_time.format(context)}',
                  style: simpleTextStyle(),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.brown[800]),
                  onPressed: _selecTime2,
                  child: Text('select the time you leave for Home'),
                ),
                SizedBox(height: 8),
                Text('Selected time: ${_time2.format(context)}',
                    style: simpleTextStyle()),
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

                GestureDetector(
                  key: new Key('addProfileKey'),
                  onTap: () {
                    addProfile();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xff3e2723),
                            const Color(0xff4e342e)
                          ],
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
          ),
        ));
  }
}
