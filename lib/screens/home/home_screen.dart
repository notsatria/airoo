import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../theme.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String>? dataSensorFuture;
  Future<bool>? dataKipasFuture;
  String dataSensor = '0';
  bool statusKipas = false;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // FirebaseDatabase db = FirebaseDatabase.instance;

  final rtdb = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://tubes-monitoring-udara-default-rtdb.asia-southeast1.firebasedatabase.app/');

  // DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  Future _showNotificationWithoutSound() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'AirooID', 'Airoo',
        channelDescription: 'Airoo Notification',
        playSound: true,
        importance: Importance.max,
        priority: Priority.high);

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Bahaya',
      'Ada kebocoran gas di rumahmu! Segera pastikan agar terhindar dari hal yang tidak diinginkan',
      platformChannelSpecifics,
      payload:
          'Segera pastikan gas Anda agar terhindar dari hal yang tidak diinginkan',
    );
  }

  // get data from firebase and return the value
  Future<String> getDataSensor() async {
    rtdb.ref().child('sensor/mq2').onValue.listen((event) {
      print(event.snapshot.value);
      final String updatedDataSensor = event.snapshot.value.toString();
      setState(() {
        dataSensor = updatedDataSensor;
      });
      if (int.parse(updatedDataSensor) > 700) {
        _showNotificationWithoutSound();
      }
    });
    return dataSensor;
  }

  Future<bool> getKipasStatus() async {
    rtdb.ref().child('kipas').onValue.listen((event) {
      print(event.snapshot.value);
      final bool updatedStatusKipas = event.snapshot.value.toString() == 'true';
      setState(() {
        statusKipas = updatedStatusKipas;
      });
    });
    return statusKipas;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dataSensorFuture = getDataSensor();
    dataKipasFuture = getKipasStatus();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  // Method 3

  @override
  Widget build(BuildContext context) {
    // widget alert dialog untuk notification
    Future onSelectNotification(String payload) async {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Payload"),
          content: Text("Payload: $payload"),
        ),
      );
    }

    Widget alertDialog() {
      return AlertDialog(
        title: const Text('Title'),
        content: const Text('message'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    }

    Widget radialGauge(String nilaiSensor) {
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
                  canRotateLabels: true,
                  minimum: 0,
                  maximum: 1024,
                  ranges: <GaugeRange>[
                    GaugeRange(
                      label: 'Normal',
                      labelStyle: const GaugeTextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      startValue: 0,
                      endValue: 350,
                      color: const Color(0xffBCE29E),
                      startWidth: 25,
                      endWidth: 25,
                    ),
                    GaugeRange(
                      label: 'Peringatan',
                      labelStyle: const GaugeTextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                      startValue: 350,
                      endValue: 700,
                      color: const Color(0xffFAFCC2),
                      startWidth: 25,
                      endWidth: 25,
                    ),
                    GaugeRange(
                      label: 'Bahaya',
                      labelStyle: const GaugeTextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      startValue: 700,
                      endValue: 1024,
                      color: const Color(0xffE97777),
                      startWidth: 25,
                      endWidth: 25,
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: nilaiSensor == '0' ? 0 : double.parse(nilaiSensor),
                      needleColor: primaryColor,
                      needleLength: 0.6,
                      knobStyle: KnobStyle(
                        color: Colors.blueGrey[400],
                      ),
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Container(
                        child: Text(
                          nilaiSensor,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.5,
                    ),
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
        int.parse(dataSensor) > 700
            ? 'Kualitas Udara Buruk'
            : int.parse(dataSensor) > 350
                ? 'Kualitas Udara Sedang'
                : 'Kualitas Udara Normal',
        style: primaryTextStyle.copyWith(
          fontSize: 20,
          fontWeight: bold,
          color: primaryColor,
        ),
      );
    }

    Widget switchKipas(bool statusKipas) {
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
                    color: secondaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      // FutureBuilder<String>(
                      //     future: dataSensorFuture,
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasData) {
                      //         final dataSensorValue = snapshot.data.toString();
                      //         return radialGauge(dataSensorValue);
                      //       } else if (snapshot.hasError) {
                      //         return Text('Error ${snapshot.error}');
                      //       } else {
                      //         return const CircularProgressIndicator();
                      //       }
                      //     }),

                      radialGauge(dataSensor),
                      textKualitasUdara(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            switchKipas(statusKipas),
          ],
        ),
      ),
    );
  }
}
