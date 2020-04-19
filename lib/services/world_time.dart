import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{
  String location;//location name for the UI
  String time;//the time in that location
  String flag;//url to an asset flag icon
  String url;//location url for api endpoint
  bool isDaytime;//ture of flase if daytime or not

  WorldTime({this.location,this.time,this.flag,this.url,});

 Future <void> getTime() async{
    try{
      Response response= await get("http://worldtimeapi.org/api/timezone/$url");
      Map date=jsonDecode(response.body);
      //print(date);

      String datetime=date['datetime'];
      String offset=date['utc_offset'].substring(1,3);

      DateTime now=DateTime.parse(datetime);
      now=now.add(Duration(hours: int.parse(offset)));
      //set time property
      isDaytime=now.hour > 24 || now.hour < 5 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      //print(e);
      time='couldnt get time data \n make sure your connected to the internet';
    }
  }

}
