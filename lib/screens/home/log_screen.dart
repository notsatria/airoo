import 'package:flutter/material.dart';
import 'package:monitoring_kualitas_udara/theme.dart';

class LogScreen extends StatelessWidget {
  const LogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget logCard() {
      return Container(
          margin: const EdgeInsets.only(top: 2, left: 10, right: 10),
          width: double.infinity,
          height: 120,
          child: Card(
            color: primaryColor,
            elevation: 3,
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.white)),
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.white)),
                1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Waktu Server: ',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: reguler,
                    ),
                  ),
                  Text(
                    'Nilai Sensor: ',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: reguler,
                    ),
                  ),
                  Text(
                    'Status Kipas: ',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: reguler,
                    ),
                  ),
                  Text(
                    'Informasi: ',
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: reguler,
                    ),
                  ),
                ],
              ),
            ),
          ));
    }

    Widget cobaLogCard() {
      return Container(
        margin: const EdgeInsets.only(top: 6),
        child: ListTile(
          tileColor: secondaryColor,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Waktu Server: ',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: reguler,
                ),
              ),
              Text(
                'Nilai Sensor: ',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: reguler,
                ),
              ),
              Text(
                'Status Kipas: ',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: reguler,
                ),
              ),
              Text(
                'Informasi: ',
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: reguler,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
          body: ListView(
        children: [
          cobaLogCard(),
          cobaLogCard(),
          cobaLogCard(),
          cobaLogCard(),
          cobaLogCard(),
        ],
      )),
    );
  }
}
