import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
// ignore: must_be_immutable
class AirQuality extends StatefulWidget {
  String ?location;
  String ?aqi;
  String ?no2;
  String ?pm;
  AirQuality({super.key, this.aqi, this.location, this.no2, this.pm});

  @override
  State<AirQuality> createState() => _AirQualityState();
}

class _AirQualityState extends State<AirQuality> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xff1C243B),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff1C243B),
        leading:  IconButton(onPressed: (){
           Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back), color: Colors.white,iconSize: 35,),
      ),
      body: SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${widget.location}", style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              ),
              const Icon(Icons.location_on_outlined, color: Colors.white, ),
              ],
            ),
             const SizedBox(height: 12,), 
          const Text("It's look like good air", style: TextStyle(
            color: Colors.white60,
            fontSize: 22
          ),),
          const SizedBox(
            height: 50,
          ),
          CircularPercentIndicator(
                radius: 130.0,
                animation: true,
                animationDuration: 1200,
                lineWidth: 15.0,
                percent: .1,
                center: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      Text(
                        "${widget.aqi}",
                        style:
                             const TextStyle(fontWeight: FontWeight.bold, fontSize: 60.0, color: Colors.white),
                      ),
                      const Text('AQI', style: TextStyle(
                        color: Colors.white60,
                        fontSize: 30,
                      ),)
                    ],
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.butt,
                backgroundColor: const Color.fromARGB(255, 65, 82, 132),
                progressColor: Colors.greenAccent,
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       Column(
                         children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                     Text("NO2", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),),
                                     Text("Good",  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 19,
                                    ),),
                                  ],
                                ),
                                Text('${widget.no2}', style: const TextStyle(
                                  fontSize: 40,
                                  color: Colors.black,
                                ),)
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                           LinearPercentIndicator(
                            barRadius: const Radius.circular(15),
                                      width: 320,
                                      lineHeight: 8.0,
                                      percent: .5,
                                      backgroundColor: Colors.grey,
                                      progressColor: Colors.blue,
                                    ),
                         ],
                       ),
                          
                          const SizedBox(height: 20,),
                                              Column(
                         children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${widget.pm}", style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),),
                                    const Text("Above average",  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 19,
                                    ),),
                                  ],
                                ),
                                const Text('40', style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.black,
                                ),)
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                           LinearPercentIndicator(
                            barRadius: const Radius.circular(15),
                                      width: 320,
                                      lineHeight: 8.0,
                                      percent: .7,
                                      backgroundColor: Colors.grey,
                                      progressColor: Colors.green.shade600,
                                    ),
                         ],
                       ),
                      ],
                    ),
                  ),
                ),
              )
        ],
      )),
    );
  }
}