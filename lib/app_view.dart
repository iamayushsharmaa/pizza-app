import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet/blocs/auth_bloc/authentication_bloc.dart';
import 'package:internet/screens/auth/view/welcome_screen.dart';
import 'package:internet/screens/home/view/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pizza Delivery App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade100,
          onBackground: Colors.black,
          primary: Colors.blue,
          onPrimary: Colors.white
        )
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if(state.status == AuthenticationStatus.authenticated){
              return HomeScreen();
            } else {
              return WelcomeScreen();
            }
          },
      ),
    );
  }
}
