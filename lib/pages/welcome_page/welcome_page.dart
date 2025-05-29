import 'package:first_flutter_project/pages/welcome_page/welcome_page_cubit.dart';
import 'package:first_flutter_project/widgets/general/background_image.dart';
import 'package:first_flutter_project/widgets/general/custom_button.dart';
import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color customColor = Color.fromARGB(255, 103, 167, 235);

    return BlocProvider(
      create: (_) => WelcomeCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            const BackgroundImage(),
            SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      title: 'Welcome!',
                      fontWeight: FontWeight.w600,
                      fontSize: 50,
                      textColor: customColor,
                    ),
                    const SizedBox(height: 50),
                    BlocBuilder<WelcomeCubit, WelcomeState>(
                      builder: (context, state) {
                        if (state.isConnected) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                buttonText: 'Login',
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/login',
                                    (route) => true,
                                  );
                                },
                                width: 150,
                                height: 50,
                                backgroundColor: customColor,
                                textColor: Colors.black,
                              ),
                              const SizedBox(width: 50),
                              CustomButton(
                                buttonText: 'Registration',
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/registration',
                                    (route) => true,
                                  );
                                },
                                width: 150,
                                height: 50,
                                backgroundColor: customColor,
                                textColor: Colors.black,
                              ),
                            ],
                          );
                        } else {
                          return const CustomText(
                            title: 'No Internet Connection',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            textColor: Colors.red,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
