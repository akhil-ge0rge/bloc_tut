import 'dart:developer';

import 'package:bloc_tut/fav/bloc/fav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    context.read<FavBloc>().add(FetchFavListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fav Items"),
        centerTitle: true,
        actions: [
          BlocBuilder<FavBloc, FavState>(
            builder: (context, state) {
              return Visibility(
                visible: state.tempFavItems.isEmpty ? false : true,
                child: IconButton(
                  onPressed: () {
                    context.read<FavBloc>().add(DeleteItemEvent());
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<FavBloc, FavState>(
        builder: (context, state) {
          switch (state.listStatus) {
            case ListStatus.loading:
              return const Center(child: CircularProgressIndicator.adaptive());
            case ListStatus.failure:
              return const Center(
                child: Text("Something Went Wrong"),
              );
            case ListStatus.sucess:
              return ListView.builder(
                itemCount: state.favItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox.adaptive(
                          value: state.tempFavItems
                                  .contains(state.favItems.elementAt(index))
                              ? true
                              : false,
                          onChanged: (val) {
                            context.read<FavBloc>().add(
                                  SelectOrUnSelectEvent(
                                    state.favItems.elementAt(index),
                                  ),
                                );
                          }),
                      title: Text(state.favItems.elementAt(index).value),
                      trailing: IconButton(
                        onPressed: () {
                          context.read<FavBloc>().add(
                              FavItemEvent(state.favItems.elementAt(index)));
                        },
                        icon: Icon(
                            state.favItems.elementAt(index).isFav
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: state.favItems.elementAt(index).isFav
                                ? Colors.red
                                : Colors.white),
                      ),
                    ),
                  );
                },
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
