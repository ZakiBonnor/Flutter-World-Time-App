import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String? location = ''; //location name of the UI
  late String? time; //time in that location
  late String? flag = ''; //url to an asset flag icon
  late String? url = '';//the location// url for api endpoint
  bool? isDaytime;

  WorldTime({this.location, this.flag, this.url});

  WorldTime.origin() {
    location = '';
    flag = '';
    url = '';
  }
  Future<void> getTime() async {
    try {

      //make the request
      var result = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(result);
      Map data = jsonDecode(response.body);
      //print(data);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //set the time property
      isDaytime = now.hour >7 && now.hour <18 ? true : false;
      time = DateFormat.jm().format(now);

    }
    catch (e) {
        print('caught error: $e');
        time='could not get time data';
    }
  }
}
