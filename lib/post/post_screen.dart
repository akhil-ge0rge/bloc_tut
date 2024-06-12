import 'dart:developer';

import 'package:bloc_tut/post/bloc/post_bloc.dart';
import 'package:bloc_tut/post/utils/post_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostScreen extends StatefulWidget {
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    context.read<PostBloc>().add(PostFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("POST"),
        centerTitle: true,
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          log(state.message);
          switch (state.postStatus) {
            case PostStatus.loading:
              return const Center(child: CircularProgressIndicator.adaptive());
            case PostStatus.failure:
              return const Center(child: Text("Something Went Wrong"));
            case PostStatus.sucess:
              return Column(
                children: [
                  TextFormField(
                    onChanged: (filterKey) {
                      context.read<PostBloc>().add(
                          SearchPostByEmailEvent(searchKeyword: filterKey));
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Search email",
                    ),
                  ),
                  Expanded(
                    child: state.searchMessage.isNotEmpty
                        ? Center(child: Text(state.searchMessage))
                        : ListView.builder(
                            itemCount: state.tempPosts.isNotEmpty
                                ? state.tempPosts.length
                                : state.posts.length,
                            itemBuilder: (context, index) {
                              final item;
                              if (state.tempPosts.isNotEmpty) {
                                item = state.tempPosts.elementAt(index);
                              } else {
                                item = state.posts.elementAt(index);
                              }

                              return Card(
                                child: ListTile(
                                  title: Text(
                                    item.email.toString(),
                                  ),
                                  subtitle: Text(item.body.toString()),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
