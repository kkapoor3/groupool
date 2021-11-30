import 'dart:convert';

import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/views/tripHistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:f_datetimerangepicker/f_datetimerangepicker.dart';
import 'package:chatapp/widget/widget.dart';

class makeATrip extends StatefulWidget {
  @override
  _makeATripState createState() => _makeATripState();
}

class _makeATripState extends State<makeATrip> {
  String from;
  String untill;
  TextEditingController nameOfTheTrip = new TextEditingController();
  TextEditingController Source = new TextEditingController();
  TextEditingController Destination = new TextEditingController();
  String dateFormatter(DateTime date) {
    dynamic dayData =
        '{ "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" }';

    dynamic monthData =
        '{ "1" : "Jan", "2" : "Feb", "3" : "Mar", "4" : "Apr", "5" : "May", "6" : "June", "7" : "Jul", "8" : "Aug", "9" : "Sep", "10" : "Oct", "11" : "Nov", "12" : "Dec" }';

    return json.decode(dayData)['${date.weekday}'] +
        ", " +
        date.day.toString() +
        " " +
        json.decode(monthData)['${date.month}'] +
        " " +
        date.year.toString();
  }

  addTrip() {
    if (nameOfTheTrip.text.isNotEmpty &&
        Source.text.isNotEmpty &&
        Destination.text.isNotEmpty) {
      Map<String, dynamic> tripData = {
        "user": Constants.myName,
        "nameOfTheTrip": nameOfTheTrip.text,
        "Source": Source.text,
        "Destination": Destination.text,
        'from': from,
        'untill': untill
      };
      DatabaseMethods().addTrip(Constants.myName, tripData);
      DatabaseMethods().addtoAllTrips(tripData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select the dates '),
        backgroundColor: Colors.brown[900],
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            key: new Key('tripNameKey'),
            style: simpleTextStyle(),
            controller: nameOfTheTrip,
            validator: (val) {
              return val.isEmpty ? "Enter Name of The Trip" : null;
            },
            decoration: textFieldInputDecoration("Name of the Trip"),
          ),
          SizedBox(
            height: 26,
          ),
          TextFormField(
            key: new Key('sourceKey'),
            style: simpleTextStyle(),
            controller: Source,
            validator: (val) {
              return val.isEmpty ? "Enter the Source" : null;
            },
            decoration: textFieldInputDecoration("Source Location"),
          ),
          SizedBox(
            height: 16,
          ),
          TextFormField(
            key: new Key('destKey'),
            style: simpleTextStyle(),
            controller: Destination,
            validator: (val) {
              return val.isEmpty ? "Enter the Destination" : null;
            },
            decoration: textFieldInputDecoration("Destination Location"),
          ),
          SizedBox(
            height: 16,
          ),
          MaterialButton(
            child: Text("Select the course of your trip"),
            color: Colors.brown[800],
            onPressed: () {
              DateTimeRangePicker(
                  startText: "From",
                  endText: "To",
                  doneText: "Yes",
                  cancelText: "Cancel",
                  interval: 5,
                  initialStartTime: DateTime.now(),
                  initialEndTime: DateTime.now().add(Duration(days: 20)),
                  mode: DateTimeRangePickerMode.dateAndTime,
                  minimumTime: DateTime.now().subtract(Duration(days: 1)),
                  maximumTime: DateTime.now().add(Duration(days: 25)),
                  use24hFormat: true,
                  onConfirm: (start, end) {
                    //print(start.day);
                    print(dateFormatter(start));
                    print(dateFormatter(end));
                    print(start.toString());
                    print(end.toString());
                    setState(() {
                      from = dateFormatter(start);
                      untill = dateFormatter(end);
                    });
                  }).showPicker(context);
            },
          ),
          Text(from ?? "Pick Start Date of your trip",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w300)),
          Text(untill ?? "Pick End Date of your trip",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'OverpassRegular',
                  fontWeight: FontWeight.w300)),
          SizedBox(
            height: 16,
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        key: new Key('addTripKey'),
        child: Icon(Icons.add),
        onPressed: () {
          addTrip();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => tripHistory()));
        },
      ),
    );
  }
}
