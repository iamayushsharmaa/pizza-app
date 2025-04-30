part of 'post_bloc.dart';

@immutable
sealed class PostState {}

abstract class PostActionState extends PostState{}

class PostInitial extends PostState {}
class PostFetchLoading extends PostState {}
class PostFetchFailure extends PostState {}

class PostFetchingSuccess extends PostState {
  final List<PostData> posts;

  PostFetchingSuccess({required this.posts});
}

class PostAdditionSucces extends PostState{}
class PostAdditionLoading extends PostState{}
class PostAdditionFailure extends PostState{}
