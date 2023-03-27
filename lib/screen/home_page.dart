import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weather_app/screen/air_quality.dart';
import 'package:weather_icons/weather_icons.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position? position;

  Map<String, dynamic> ?weatherMap;
  Map<String, dynamic> ?forecastMap;
   Map<String, dynamic> ?airQualityMap;

  determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;


  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {

      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {

    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  
  position =  await Geolocator.getCurrentPosition();
  getData();
  // print('${position!.latitude} ${position!.longitude}');

}

getData()async{
  var weather = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${position!.latitude}&lon=${position!.longitude}&appid=055e908178aff301390ddcfabfcbe829&units=metric'));
  var forecast = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/forecast?lat=${position!.latitude}&lon=${position!.longitude}&appid=055e908178aff301390ddcfabfcbe829&units=metric'));
  var airQuality = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/air_pollution?lat=${position!.latitude}&lon=${position!.longitude}&appid=055e908178aff301390ddcfabfcbe829'));
  
  var weatherData = await jsonDecode(weather.body);
  var forecastData = await jsonDecode(forecast.body);
  var airQualityData = await jsonDecode(airQuality.body);

  setState(() {
    weatherMap = Map.from(weatherData);
    forecastMap = Map.from(forecastData);
    airQualityMap = Map.from(airQualityData);
  });

}
final f = DateFormat('EEEE, dd MMMM');
final d = DateFormat('hh');
@override
  void initState() {
    determinePosition();
    
   
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1C243B),
      body: weatherMap!=null ? SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${weatherMap!["name"]}', style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16
                  ),),
                  const SizedBox(width: 5,),
              
                  const Icon(Icons.location_on_outlined, color: Colors.white,),
                ],
              ),
              const SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${weatherMap!["main"]["temp"]}°', style: const TextStyle(
                      color: Color(0xffFAFEFF),
                      fontSize: 60
                    ),),
                   Container(
                    height: 60,
                    width: 3,
                    color: const Color(0xff7A808C),
                   ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${weatherMap!["weather"][0]["main"]}', style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                    ),),
                    const SizedBox(height: 15,),
                        Text(f.format(DateTime.now()), style: const TextStyle(
                      color: Color(0xff787F91),
                      fontSize: 16
                    ),),
                      ],
                    ),
                  ],
                ),
              ),

                 Container(
                  height: 170,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(image:  NetworkImage("https://openweathermap.org/img/wn/${weatherMap!["weather"][0]["icon"]}@2x.png",),
                    fit: BoxFit.fill,)
                  ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xffCFD0E2)
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 40),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:const [
                                     BoxedIcon(WeatherIcons.humidity, size: 18,),
                                     SizedBox(height: 20,),
                                     BoxedIcon(WeatherIcons.wind, size: 18,),
                                    
                                    
                                  ],

                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:const [
                                     Text("Humidity", style: TextStyle(
                                      color: Color(0xff9A9DA8),
                                      fontSize: 16
                                    ),),
                                     SizedBox(height: 25,),
                                     Text("Wind", style: TextStyle(
                                        color: Color(0xff9A9DA8),
                                        fontSize: 16
                                      ),),
                                    
                                    
                                  ],

                                ),
                                 Column(
                                children: [
                                  Container(
                                  height: 20,
                                  width: 3,
                                  color: const Color(0xff9A9DA8),
                                ),
                                   const SizedBox(height: 25,),
                                  Container(
                                    height: 20,
                                    width: 3,
                                    color: const Color(0xff9A9DA8),
                                  ),
                                  // SizedBox(width: 30,),
                                 
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                      Text('${weatherMap!["main"]["humidity"]}%', style: const TextStyle(
                                  color: Color(0xff9A9DA8),
                                  fontSize: 16
                                ),),
                                 const SizedBox(height: 25,),
                                       Text('${weatherMap!["wind"]["speed"]}km/h', style: const TextStyle(
                                    color: Color(0xff9A9DA8),
                                    fontSize: 16
                                  ),),
                                ],
                              )
                              ],
                            ),
                            const SizedBox(height: 20,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> AirQuality(
                                  aqi: airQualityMap!["list"][0]["main"]["aqi"].toString(),
                                  location: weatherMap!["name"].toString(),
                                  no2: airQualityMap!["list"][0]["components"]["no2"].toString(),
                                  pm: airQualityMap!["list"][0]["components"]["pm2_5"].toString(),
                                )));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                    height: 25,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xff1C243B),
                                    ),
                                    child: const Text('Air Quality', style: TextStyle(
                                      color: Colors.white,
                                    ),),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                   ),
                 ),
                 const SizedBox(height: 20,),
                 const Padding(
                   padding: EdgeInsets.symmetric(horizontal: 20),
                   child: Divider(
                    color: Color(0xff43495F),
                    thickness: 1.0,
                    
                   ),
                 ),
                 const SizedBox(height: 30,),
                 Expanded(
                   child: ListView.separated(
                    itemCount: 20,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                    return  SizedBox(
                        height: 50,
                        width: 60,
                        child: Column(
                          children: [
                            Text(Jiffy('${forecastMap!["list"][index]["dt_txt"]}').format('hh a'), style: const TextStyle(
                              color: Colors.white54,

                            ),),
                            Image.network("https://openweathermap.org/img/wn/${forecastMap!["list"][index]["weather"][0]["icon"]}@2x.png", ),
                            Text('${forecastMap!["list"][index]["main"]["temp"]}°', style: const TextStyle(
                              color: Colors.white54,
                              
                            ),)
                          ],
                        ),
                    );
                   }, separatorBuilder: (context, index){
                      return  const SizedBox(width: 10);
                   }),
                 )
            ],
          ),
        ),
      ): const Center(child: CircularProgressIndicator(),),
    );
  }
}