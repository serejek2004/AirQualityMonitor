import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {  
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
                const Text(
                    'Welcome USER_NAME!', 
                    style: TextStyle(
                      fontSize: 32, 
                      fontFamily: 'Times New Roman',
                      color: Color.fromARGB(209, 103, 167, 235), 
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const SizedBox(height: 40, width: double.infinity),
                const SizedBox(
                  width: 375,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Temperature: min - max',
                        style: TextStyle(
                          fontSize: 22, 
                          fontFamily: 'Times New Roman',
                          color: Color.fromARGB(209, 103, 167, 235), 
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Humidity: min - max',
                        style: TextStyle(
                          fontSize: 22, 
                          fontFamily: 'Times New Roman',
                          color: Color.fromARGB(209, 103, 167, 235), 
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'CO2: min - max',
                        style: TextStyle(
                          fontSize: 22, 
                          fontFamily: 'Times New Roman',
                          color: Color.fromARGB(209, 103, 167, 235), 
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
                SizedBox(
                  width: 350,
                  child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/profileEdit',
                                (route) => true,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: 
                                const Color.fromARGB(209, 103, 167, 235),
                            ),
                            child: const Text(
                              'Profile edit',
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
                                '/home',
                                (route) => true,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: 
                                const Color.fromARGB(209, 103, 167, 235),
                            ),
                            child: const Text(
                              'Home',
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
