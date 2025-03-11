import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

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
                  'Login',
                  style: TextStyle(
                    color: Color.fromARGB(255, 103, 167, 235), 
                    fontFamily: 'Times New Roman',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5, width: double.infinity,),
                const SizedBox(
                  width: 350,
                  child: TextField(
                    style: TextStyle(
                      color: Color.fromARGB(255, 103, 167, 235), 
                    ),
                    cursorColor: Color.fromARGB(255, 103, 167, 235),
                    decoration: InputDecoration(
                      labelText: 'Login',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 103, 167, 235), 
                        fontFamily: 'Times New Roman',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 103, 167, 235), 
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20, width: double.infinity,),
                const Text(
                  'Password',
                  style: TextStyle(
                    color: Color.fromARGB(209, 103, 167, 235),
                    fontFamily: 'Times New Roman',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5, width: double.infinity,),
                const SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: Color.fromARGB(255, 103, 167, 235), 
                    ),
                    cursorColor: Color.fromARGB(255, 103, 167, 235),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 103, 167, 235), 
                        fontFamily: 'Times New Roman',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 103, 167, 235), 
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20, width: double.infinity,),
                const Text(
                  'Password confirm',
                  style: TextStyle(
                    color: Color.fromARGB(209, 103, 167, 235),
                    fontFamily: 'Times New Roman',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5, width: double.infinity,),
                const SizedBox(
                  width: 350,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: Color.fromARGB(255, 103, 167, 235),
                    ),
                    cursorColor: Color.fromARGB(255, 103, 167, 235),
                    decoration: InputDecoration(
                      labelText: 'Password confirm',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 103, 167, 235), 
                        fontFamily: 'Times New Roman',
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 103, 167, 235),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
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
          ),
        ],
      ),
    );
  }
}
