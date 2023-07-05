import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String sensor = '0';
  bool statusKipas = false;
  late DatabaseReference sensorRef;

  @override
  void initState() {
    super.initState();
    // final sensorRef = FirebaseDatabase.instance.ref();

    // sensorRef.onValue.listen((DatabaseEvent event) {
    //   setState(() {
    //     sensor = event.snapshot.value.toString();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    Widget radialGauge() {
      return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Center(
          child: SizedBox(
            width: 240,
            height: 240,
            child: SfRadialGauge(
              animationDuration: 5000,
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 1024,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: 0,
                      endValue: 250,
                      color: Colors.green,
                      startWidth: 20,
                      endWidth: 20,
                    ),
                    GaugeRange(
                      startValue: 250,
                      endValue: 700,
                      color: Colors.yellow,
                      startWidth: 20,
                      endWidth: 20,
                    ),
                    GaugeRange(
                      startValue: 700,
                      endValue: 1024,
                      color: Colors.red,
                      startWidth: 20,
                      endWidth: 20,
                    ),
                  ],
                  pointers: const <GaugePointer>[
                    NeedlePointer(
                      value: 1024,
                      needleColor: Colors.white,
                      needleLength: 0.6,
                      knobStyle: KnobStyle(
                        color: Colors.black,
                      ),
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            sensor,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.5),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget textKualitasUdara() {
      return Text(
        'Kualitas Udara Normal',
        style: whiteTextStyle.copyWith(
          fontSize: 20,
          fontWeight: semiBold,
        ),
      );
    }

    Widget switchKipas() {
      return Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status Kipas',
                  style: primaryTextStyle.copyWith(
                    fontSize: 20,
                    fontWeight: semiBold,
                  ),
                ),
                statusKipas
                    ? Text(
                        'Menyala',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: reguler,
                          color: primaryColor,
                        ),
                      )
                    : Text(
                        'Mati',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: reguler,
                          color: primaryColor,
                        ),
                      )
              ],
            ),
            trailing: Switch(
              value: statusKipas,
              onChanged: (bool value) {
                setState(() {
                  statusKipas = value;
                });
              },
              activeColor: primaryColor,
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 320,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
                Column(
                  children: [
                    radialGauge(),
                    textKualitasUdara(),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            switchKipas(),
          ],
        ),
      ),
    );
  }
}
