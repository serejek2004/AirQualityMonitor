import 'package:first_flutter_project/pages/registration_page/registration_cubit.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_input.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(255, 103, 167, 235);
    final loginController = TextEditingController();
    final passwordController = TextEditingController();
    final cPasswordController = TextEditingController();
    final isConnected = context.watch<NetworkService>().isConnected;

    return BlocProvider(
      create: (_) => RegistrationCubit(
        userService: Provider.of(context, listen: false),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: BlocConsumer<RegistrationCubit, RegistrationState>(
                    listener: (context, state) {
                      if (state is RegistrationError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message, 
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (state is RegistrationSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'User successfully registered', 
                              textAlign: TextAlign.center,
                            ),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
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
                            controller: loginController,
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                            label: 'Password',
                            obscureText: true,
                            fieldWidth: 350,
                            textColor: customColor,
                            cursorColor: customColor,
                            focusedBorderColor: customColor,
                            controller: passwordController,
                          ),
                          const SizedBox(height: 20),
                          CustomInput(
                            label: 'Confirm Password',
                            obscureText: true,
                            fieldWidth: 350,
                            textColor: customColor,
                            cursorColor: customColor,
                            focusedBorderColor: customColor,
                            controller: cPasswordController,
                          ),
                          const SizedBox(height: 20),
                          if (isConnected)
                            state is RegistrationLoading
                                ? const CircularProgressIndicator()
                                : CustomButton(
                                    buttonText: 'Register',
                                    onPressed: () {
                                      context.read<RegistrationCubit>()
                                      .register(
                                            loginController.text.trim(),
                                            passwordController.text,
                                            cPasswordController.text,
                                          );
                                    },
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
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
