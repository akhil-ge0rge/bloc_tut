part of 'fav_bloc.dart';

enum ListStatus { loading, sucess, failure }

class FavState extends Equatable {
  final List<FavItemModel> favItems;
  final List<FavItemModel> tempFavItems;
  final ListStatus listStatus;
  const FavState({
    this.favItems = const [],
    this.tempFavItems = const [],
    this.listStatus = ListStatus.loading,
  });

  FavState copyWith(
      {List<FavItemModel>? favItems,
      List<FavItemModel>? tempFavItems,
      ListStatus? listStatus}) {
    return FavState(
        favItems: favItems ?? this.favItems,
        tempFavItems: tempFavItems ?? this.tempFavItems,
        listStatus: listStatus ?? this.listStatus);
  }

  @override
  List<Object> get props => [favItems, listStatus, tempFavItems];
}
