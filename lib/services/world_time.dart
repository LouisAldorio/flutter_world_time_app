import 'package:flutter/foundation.dart';
import "package:http/http.dart";
import "dart:convert";
import "package:intl/intl.dart";

class WorldTime {

  late String location; // location name for the UI
  late String time; // time in that location

  late String flag; // the country flag icon
  late String url; // location ID Timezone for api endpoint
  late bool isDayTime;

  WorldTime({
    required this.location,
    required this.flag,
    required this.url,
  });

  // future make the function return something like promise in JS
  Future<void> getTime() async {

    try {
      // make the request
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data["datetime"];
      String offset = data["utc_offset"].substring(1,3); // from +01:00 to 01

      // create datetime object
      // convert string to time , similar to time.parse in golang
      DateTime utcNow = DateTime.parse(datetime);
      DateTime localNow = utcNow.add(Duration(hours: int.parse(offset)));

      // set time property
      isDayTime = localNow.hour > 6 && localNow.hour < 20 ? true : false;
      time = DateFormat.jm().format(localNow);
    }catch(err) {
      if (kDebugMode) {
        print("err = $err");
      }
      time = "could not get time data";
      isDayTime = false;
    }
  }
}