import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffffec99),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      BusCard(
                        busName: 'Bus 1',
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BusCard(
                        busName: 'Bus 2',
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BusCard(
                        busName: 'Bus 3',
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BusCard(
                        busName: 'Bus 4',
                        onTap: () {
                          Navigator.pushNamed(context, '/bus-page');
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BusCard(
                        busName: 'Bus 5',
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Positioned(
                bottom: 0,
                right: 0,
                child: Image(
                  image: AssetImage('lib/assets/homepage.png'),
                ))
          ],
        ));
  }
}

class BusCard extends StatelessWidget {
  final String busName;
  Function? onTap;
  BusCard({
    super.key,
    required this.busName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 50,
              offset: Offset(0, 10)),
          BoxShadow(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, -10))
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          busName,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: const Color(0xff000000),
            textStyle: const TextStyle(letterSpacing: 1),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap as void Function()?,
      ),
    );
  }
}
