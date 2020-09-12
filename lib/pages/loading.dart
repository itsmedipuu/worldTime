import 'package:flutter/material.dart';
import '../services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<void> setTime() async {
    WorldTime instance = WorldTime();
    await instance.getTimeByIp();

    await Future.delayed(Duration(seconds: 1), () {
      //print('Waited 1 seconds... done');
    });

    //Passing data using Navigator
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  void initState() {
    super.initState();
    setTime();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[500],
        body: Center(
          child: SpinKitRing(
            color: Colors.blue[900],
            size: 50.0,
          ),
        ),
      ),
    );
  }
}
