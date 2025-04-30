import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet/api/bloc/post_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  final PostBloc postBloc = PostBloc();

  @override
  void initState() {
    postBloc.add(PostInitialFetchEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts page'),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is !PostActionState,
        builder: (context, state) {
          switch(state.runtimeType){
            case PostFetchingSuccess:
              final successState = state as PostFetchingSuccess;
              return Container(
                child: ListView.builder(itemCount: successState.posts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey.shade200,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(successState.posts[index].title),
                            Text(successState.posts[index].body),
                          ],
                        ),
                      );
                    }
                ),
              );
            default:
              return SizedBox(height: 5,);
          }
          },
        listener: (context, state) {

          },
      ),
    );
  }
}
