import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet/component/my_textfields.dart';
import 'package:internet/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMsg;
  bool signUpRequired = false;

  bool containsUpperCase = false;
  bool containseLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialCharacter = false;
  bool containsBLength = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if(state is SignUpSuccess){
            setState(() {
              signUpRequired = false;
            });
          } else if(state is SignUpProcess){
            setState(() {
              signUpRequired = true;
            });
          } else if(state is SignUpFailure){
            return;
          }
        },
      child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextfields(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    errorMsg: _errorMsg,
                    validator: (val) {
                      if(val!.isEmpty){
                        return 'Please enter your email';
                      } else if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)){
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextfields(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    errorMsg: _errorMsg,
                    onChanged:  (val){
                      if(val!.contains(RegExp(r'^[A-Z]'))){
                        setState(() {
                          containsUpperCase = true;
                        });
                      } else {
                        setState(() {
                          containsUpperCase = false;
                        });
                      }
                      if(val.contains(RegExp(r'^[a-z]'))){
                        setState(() {
                          containseLowerCase = true;
                        });
                      } else {
                        setState(() {
                          containseLowerCase = false;
                        });
                      }
                      if(val.contains(RegExp(r'^[0-9]'))){
                        setState(() {
                          containsNumber = true;
                        });
                      } else{
                        setState(() {
                          containsNumber = false;
                        });
                      }
                      if(val.contains(RegExp(r'^(?=.*?[!@#\$&*~)'))){
                        setState(() {
                          containsSpecialCharacter = true;
                        });
                      } else{
                        setState(() {
                          containsSpecialCharacter = false;
                        });
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                            if(obscurePassword){
                              iconPassword = CupertinoIcons.eye_fill;
                            }else{
                              iconPassword = CupertinoIcons.eye_slash_fill;
                            }
                          });
                        },
                        icon: Icon(iconPassword)
                    ),
                    validator: (val) {
                      if(val!.isEmpty){
                        return 'Please fill in this field';
                      } else if(!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$').hasMatch(val)){
                        return 'Password enter a valid password';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1 uppercase',
                          style: TextStyle(
                            color: containsUpperCase
                                ?Colors.green
                                :Theme.of(context).colorScheme.onBackground
                          ),
                        ),
                        Text(
                          '1 lowercase',
                          style: TextStyle(
                              color: containsUpperCase
                                  ?Colors.green
                                  :Theme.of(context).colorScheme.onBackground
                          ),
                        ),
                        Text(
                          '1 number',
                          style: TextStyle(
                              color: containsUpperCase
                                  ?Colors.green
                                  :Theme.of(context).colorScheme.onBackground
                          ),
                        ),
                      ]
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '1 special character',
                          style: TextStyle(
                              color: containsUpperCase
                                  ?Colors.green
                                  :Theme.of(context).colorScheme.onBackground
                          ),
                        ),
                        Text(
                          '8 minimun character',
                          style: TextStyle(
                              color: containsUpperCase
                                  ?Colors.green
                                  :Theme.of(context).colorScheme.onBackground
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: MyTextfields(
                    controller: nameController,
                    hintText: 'Name',
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(CupertinoIcons.person_fill),
                    validator: (val) {
                      if(val!.isEmpty){
                        return 'Please fill in this field';
                      } else if(val.length > 30){
                        return 'Name is too long';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                !signUpRequired
                    ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()){
                            MyUser myUser = MyUser.empty;
                            myUser.email = emailController.text;
                            myUser.name = nameController.text;
                            setState(() {
                              context.read<SignUpBloc>().add(
                                SignUpRequired(
                                    myUser,
                                    passwordController.text
                                )
                              );
                            });
                          }
                        },
                        style: TextButton.styleFrom(
                          elevation: 3.0,
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)
                          )
                        ),
                        child: const Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                    )
                )
                    : const CircularProgressIndicator()
              ],
            ),
          )
      ),
    );
  }
}
