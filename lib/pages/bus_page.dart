import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:where_is_my_bus/utils/firebase_utils.dart';

class BusPage extends StatelessWidget {
  const BusPage({super.key});

  Future<BusDetails> _getBusDetails() async {
    FirebaseUtils fu = FirebaseUtils();
    BusDetails busDetails = await fu.getBusDetails();
    return busDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffec99),
          title: Center(
            child: Text(
              "where is my college bus?",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xff000000),
                textStyle: const TextStyle(letterSpacing: 1),
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      FutureBuilder(
                          future: _getBusDetails(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return const Text("Error");
                            } else {
                              /*  final String busName;
                                  final int capacity;
                                  final String conductorName;
                                  final String driverName;
                                  final String endLocation;
                                  final String endTime;
                                  final String model;
                                  final String remarks;
                                  final bool running;
                                  final String startLocation;
                                  final String startTime;
                                  final String type; 
                              */
                              BusDetails busDetails =
                                  snapshot.data as BusDetails;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        busDetails.busName,
                                        style: GoogleFonts.poppins(
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.yellow[800],
                                          textStyle:
                                              const TextStyle(letterSpacing: 1),
                                        ),
                                      ),
                                      // display a track now button
                                      // if the bus is running
                                      if (busDetails.running)
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      if (busDetails.running)
                                        IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/maps');
                                          },
                                          icon: const Icon(
                                              Icons.my_location_rounded),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.yellow[300],
                                            textStyle: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w300,
                                              color: const Color(0xff000000),
                                              textStyle: const TextStyle(
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Driver: ${busDetails.driverName}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff000000),
                                          textStyle:
                                              const TextStyle(letterSpacing: 1),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Text(
                                        "Conductor: ${busDetails.conductorName}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff000000),
                                          textStyle:
                                              const TextStyle(letterSpacing: 1),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Start Location: ${busDetails.startLocation}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff000000),
                                      textStyle:
                                          const TextStyle(letterSpacing: 1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "End Location: ${busDetails.endLocation}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff000000),
                                      textStyle:
                                          const TextStyle(letterSpacing: 1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Start Time: ${busDetails.startTime}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff000000),
                                      textStyle:
                                          const TextStyle(letterSpacing: 1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "End Time: ${busDetails.endTime}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff000000),
                                      textStyle:
                                          const TextStyle(letterSpacing: 1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Model: ${busDetails.model}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff000000),
                                      textStyle:
                                          const TextStyle(letterSpacing: 1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${busDetails.remarks}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff000000),
                                      textStyle:
                                          const TextStyle(letterSpacing: 1),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              );
                            }
                          })
                    ],
                  ),
                ),
              ],
            ),
            const Positioned(
                bottom: 0,
                left: 0,
                child: Image(
                  height: 250,
                  image: AssetImage('lib/assets/buspage.png'),
                ))
          ],
        ));
  }
}
