import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet/app_view.dart';
import 'package:internet/blocs/auth_bloc/authentication_bloc.dart';
import 'package:internet/simple_bloc_observer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(new MyApp());
}


class MyApp extends StatelessWidget {
  final UserRepository userRepository;
  const MyApp({super.key, this.userRepository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc(
        userRepository: userRepository
      ),
      child: MyAppView(),
    );
  }
}
