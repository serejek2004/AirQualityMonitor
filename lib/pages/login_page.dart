import 'package:first_flutter_project/services/abstract/user_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_input.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final Color customColor = const Color.fromARGB(255, 103, 167, 235);
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> _login() async {
    final login = _loginController.text;
    final password = _passwordController.text;

    final userService = Provider.of<UserService>(context, listen: false);
    final user = await userService.validateUser(login, password);

    if (!mounted) return;

    if (user) {
      _navigateToHome();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Wrong login or password'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    title: 'Login',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    textColor: customColor,
                  ),
                  const SizedBox(height: 5),
                  CustomInput(
                    label: 'Login',
                    obscureText: false,
                    fieldWidth: 350,
                    textColor: customColor,
                    cursorColor: customColor,
                    focusedBorderColor: customColor,
                    controller: _loginController,
                  ),
                  const SizedBox(height: 20),
                  CustomText(
                    title: 'Password',
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                    textColor: customColor,
                  ),
                  const SizedBox(height: 5),
                  CustomInput(
                    label: 'Password',
                    obscureText: true,
                    fieldWidth: 350,
                    textColor: customColor,
                    cursorColor: customColor,
                    focusedBorderColor: customColor,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    buttonText: 'Login',
                    onPressed: _login,
                    width: 150,
                    height: 50,
                    backgroundColor: customColor,
                    textColor: Colors.black,
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
