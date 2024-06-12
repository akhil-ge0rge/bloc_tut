part of 'fav_bloc.dart';

sealed class FavEvent extends Equatable {
  const FavEvent();

  @override
  List<Object> get props => [];
}

class FetchFavListEvent extends FavEvent {}

class FavItemEvent extends FavEvent {
  final FavItemModel favItem;

  const FavItemEvent(this.favItem);
  @override
  List<Object> get props => [favItem];
}

class SelectOrUnSelectEvent extends FavEvent {
  final FavItemModel favItem;

  const SelectOrUnSelectEvent(this.favItem);
  @override
  List<Object> get props => [favItem];
}

class DeleteItemEvent extends FavEvent {}
