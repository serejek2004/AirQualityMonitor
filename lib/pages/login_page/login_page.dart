import 'package:first_flutter_project/pages/login_page/login_cubit.dart';
import 'package:first_flutter_project/services/abstract/user_service.dart';
import 'package:first_flutter_project/services/not_abstract/network_service.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_input.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(255, 103, 167, 235);
    final isConnected = context.watch<NetworkService>().isConnected;

    final loginController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => LoginCubit(userService: context.read<UserService>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                const BackgroundImage(),
                SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomText(
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
                          controller: loginController,
                        ),
                        const SizedBox(height: 20),
                        const CustomText(
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
                          controller: passwordController,
                        ),
                        const SizedBox(height: 20),
                        if (isConnected)
                          state is LoginLoading
                              ? const CircularProgressIndicator()
                              : CustomButton(
                                  buttonText: 'Login',
                                  onPressed: () {
                                    final login = loginController.text;
                                    final password = passwordController.text;
                                    context
                                        .read<LoginCubit>()
                                        .login(login, password);
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
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
