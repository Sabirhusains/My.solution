import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/repository/api_repository.dart';
import 'locator.dart';
import 'presentation/cubit/chat/chat_cubit.dart';
import 'presentation/view/home_screen.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(const Duration(seconds: 3), () {
  //     navigatorKey.currentState
  //         ?.pushReplacementNamed(RouteName.onboardingScreen);
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 2500,
      splash: 'assets/images/logo.png',
      splashIconSize: 300,
      nextScreen:BlocProvider(
        create: (context) {
          return ChatCubit(
            locator<ApiRepository>(),
          );
        },
        child: const MyHomePage(),
      ),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: const Color(0xffE2BFB3),
      centered: true,
    );
  }
}
