import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:internet/api/data/models/PostData.dart';
import 'package:internet/api/data/repository/repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postInitialFetchEvent(PostInitialFetchEvent event, Emitter<PostState> emit) async {
    List<PostData> posts = await PostRepository.fetchPost();
    emit(PostFetchingSuccess(posts: posts));
  }

  FutureOr<void> postAddEvent(PostAddEvent event, Emitter<PostState> emit) async {
    emit(PostAdditionLoading());
    bool result = await PostRepository.addPost();
    if(result) {
      emit(PostAdditionSucces());
    } else {
      emit(PostAdditionFailure());
    }
  }
}
