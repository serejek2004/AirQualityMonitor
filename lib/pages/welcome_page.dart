import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {  
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome!', 
                    style: TextStyle(
                      fontSize: 50, 
                      fontFamily: 'Times New Roman',
                      color: Color.fromARGB(209, 103, 167, 235), 
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/login',
                              (route) => true,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(209, 103, 167, 235),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Times New Roman', 
                              fontSize: 18, 
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/registration',
                              (route) => true,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(209, 103, 167, 235),
                          ),
                          child: const Text(
                            'Registration',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
