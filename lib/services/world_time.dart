import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDayTime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTimeByIp() async {
    try {
      Response response = await get("http://worldtimeapi.org/api/ip");
      parseData(response);
    } catch (e) {
      print('error: $e');
      time = "Error Getting Time";
    }
  }

  Future<void> getTime() async {
    try {
      //make request
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      parseData(response);
    } catch (e) {
      print('error: $e');
      time = 'Error Getting Time';
    }
  }

  void parseData(Response response) {
    Map data = jsonDecode(response.body);

    // find the location for initial loading
    if (location == null) {
      String timezone = data['timezone'];
      location = timezone.substring(timezone.lastIndexOf('/') + 1);
    }

    //fetching reqd data from api
    String datetime = data['datetime'];
    String offset = data['utc_offset'];
    String offHrs = offset.substring(1, 3);
    String offMins = offset.substring(4, 6);

    //Creating datetime object
    DateTime now = DateTime.parse(datetime);
    now = now
        .add(Duration(hours: int.parse(offHrs), minutes: int.parse(offMins)));

    //For image
    isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
    //set the time property
    time = DateFormat.jm().format(now);
  }
}
