import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_tut/fav/repository/fav_repository.dart';
import 'package:equatable/equatable.dart';

import '../model/fav_item_model.dart';

part 'fav_event.dart';
part 'fav_state.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  FavRepository favRepository;
  List<FavItemModel> favItem = [];
  List<FavItemModel> tempFavItem = [];

  FavBloc({required this.favRepository}) : super(const FavState()) {
    on<FetchFavListEvent>(_fetchFavItems);
    on<FavItemEvent>(_addFavItem);
    on<SelectOrUnSelectEvent>(_selectOrUnSelectItem);
    on<DeleteItemEvent>(_deleteItem);
  }

  void _fetchFavItems(FetchFavListEvent event, Emitter<FavState> emit) async {
    try {
      emit(state.copyWith(favItems: null, listStatus: ListStatus.loading));
      favItem = await favRepository.fetchItem();
      emit(state.copyWith(
          favItems: List.from(favItem), listStatus: ListStatus.sucess));
    } catch (e) {
      emit(state.copyWith(favItems: null, listStatus: ListStatus.failure));
    }
  }

  void _addFavItem(FavItemEvent event, Emitter<FavState> emit) {
    FavItemModel item = FavItemModel(
      id: event.favItem.id,
      value: event.favItem.value,
      isDeleting: false,
      isFav: !event.favItem.isFav,
    );

    final index = favItem.indexWhere((element) => element.id == item.id);
    if (tempFavItem.contains(event.favItem)) {
      tempFavItem.removeWhere(
        (element) => element.id == item.id,
      );
      tempFavItem.add(item);
    }

    favItem[index] = item;

    emit(
      state.copyWith(
          favItems: List.from(favItem), tempFavItems: List.from(tempFavItem)),
    );
  }

  void _selectOrUnSelectItem(
      SelectOrUnSelectEvent event, Emitter<FavState> emit) {
    if (tempFavItem.contains(event.favItem)) {
      tempFavItem.remove(event.favItem);
    } else {
      tempFavItem.add(event.favItem);
    }

    emit(state.copyWith(tempFavItems: List.from(tempFavItem)));
  }

  void _deleteItem(DeleteItemEvent event, Emitter<FavState> emit) {
    for (int i = 0; i < tempFavItem.length; i++) {
      favItem.remove(tempFavItem.elementAt(i));
    }
    tempFavItem.clear();
    emit(state.copyWith(
      favItems: List.from(favItem),
      tempFavItems: tempFavItem,
    ));
  }
}
