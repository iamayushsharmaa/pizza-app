part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class SignInRequired extends SignInEvent{
  final String email;
  final String password;

  const SignInRequired({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];

}

class SignOutRequired extends SignInEvent{}