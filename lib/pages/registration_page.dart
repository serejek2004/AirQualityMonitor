import 'package:first_flutter_project/services/abstract/user_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_input.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final Color customColor = const Color.fromARGB(255, 103, 167, 235);
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  Future<void> _register() async {
    final login = _loginController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _cPasswordController.text;
    final userService = Provider.of<UserService>(context, listen: false);

    if (login.length < 3 || login.length > 20) {
      _showError('Login must be between 3 and 20 characters');
      return;
    }

    if (password.length < 8 || password.length > 20) {
      _showError('Password must be between 8 and 20 characters');
      return;
    }

    if (password != confirmPassword) {
      _showError('Passwords do not match');
      return;
    }

    final isRegistered = await userService.registerUser(login, password);

    if (!mounted) return;

    if (isRegistered) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'User successfully registered', 
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/home',
        (route) => false,
      );
    } else {
      _showError('User already exists. Try a different login.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, textAlign: TextAlign.center),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = context.watch<NetworkService>().isConnected;

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
                    title: 'Register',
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
                  CustomInput(
                    label: 'Confirm Password',
                    obscureText: true,
                    fieldWidth: 350,
                    textColor: customColor,
                    cursorColor: customColor,
                    focusedBorderColor: customColor,
                    controller: _cPasswordController,
                  ),
                  const SizedBox(height: 20),
                  if (isConnected)
                    CustomButton(
                      buttonText: 'Register',
                      onPressed: _register,
                      width: 150,
                      height: 50,
                      backgroundColor: customColor,
                      textColor: Colors.black,
                    )
                  else
                    const CustomText(
                      title: 'No Internet connection',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      textColor: Colors.red,
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
