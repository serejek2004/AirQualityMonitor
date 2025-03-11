import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  final String description = 'This application will help you monitor temperature, humidity and CO2 levels. If the minimum or maximum set parameters are violated, an alarm will be sent.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://surl.li/pfiagj',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: double.infinity,),
                const Text('Air quality monitor', style: TextStyle(
                    color: Colors.white, 
                    fontFamily: 'Times New Roman',
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 350,
                  child: Text(description, style: const TextStyle(
                      color: Colors.white, 
                      fontFamily: 'Times New Roman',
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/profile',
                                (route) => true,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(209, 103, 167, 235),
                            ),
                            child: const Text(
                              'Profile',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Times New Roman', 
                                fontSize: 18, 
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/',
                                (route) => true,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(209, 103, 167, 235),
                            ),
                            child: const Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Times New Roman', 
                                fontSize: 18, 
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
