part of 'post_bloc.dart';

sealed class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostFetchEvent extends PostEvent {}

class SearchPostByEmailEvent extends PostEvent {
  final String searchKeyword;

  const SearchPostByEmailEvent({required this.searchKeyword});
  @override
  List<Object> get props => [searchKeyword];
}
