import 'package:flutter/material.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

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
                  'New temperature',
                  style: TextStyle(
                    color: Color.fromARGB(255, 103, 167, 235), 
                    fontFamily: 'Times New Roman',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5, width: double.infinity,),
                const SizedBox(
                  width: 400, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 175,
                        child: TextField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 103, 167, 235), 
                          ),
                          cursorColor: Color.fromARGB(255, 103, 167, 235),
                          decoration: InputDecoration(
                            labelText: 'Min temperature',
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
                      SizedBox(
                        width: 175,
                        child: TextField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 103, 167, 235), 
                          ),
                          cursorColor: Color.fromARGB(255, 103, 167, 235),
                          decoration: InputDecoration(
                            labelText: 'Max temperature',
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
                    ],
                  ),
                ),
                const Text(
                  'New humidity',
                  style: TextStyle(
                    color: Color.fromARGB(255, 103, 167, 235), 
                    fontFamily: 'Times New Roman',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5, width: double.infinity,),
                const SizedBox(
                  width: 400, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 175,
                        child: TextField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 103, 167, 235), 
                          ),
                          cursorColor: Color.fromARGB(255, 103, 167, 235),
                          decoration: InputDecoration(
                            labelText: 'Min humidity',
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
                      SizedBox(
                        width: 175,
                        child: TextField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 103, 167, 235), 
                          ),
                          cursorColor: Color.fromARGB(255, 103, 167, 235),
                          decoration: InputDecoration(
                            labelText: 'Max humidity',
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
                    ],
                  ),
                ),
                const Text(
                  'New CO2',
                  style: TextStyle(
                    color: Color.fromARGB(255, 103, 167, 235), 
                    fontFamily: 'Times New Roman',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5, width: double.infinity,),
                const SizedBox(
                  width: 400, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 175,
                        child: TextField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 103, 167, 235), 
                          ),
                          cursorColor: Color.fromARGB(255, 103, 167, 235),
                          decoration: InputDecoration(
                            labelText: 'Min CO2',
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
                      SizedBox(
                        width: 175,
                        child: TextField(
                          style: TextStyle(
                            color: Color.fromARGB(255, 103, 167, 235), 
                          ),
                          cursorColor: Color.fromARGB(255, 103, 167, 235),
                          decoration: InputDecoration(
                            labelText: 'Max CO2',
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
                    ],
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
                        '/profile',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(209, 103, 167, 235),
                    ),
                    child: const Text(
                      'Update',
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
