import 'package:bloc/bloc.dart';
import 'package:bloc_tut/post/model/post_model.dart';
import 'package:bloc_tut/post/repository/post_repository.dart';
import 'package:bloc_tut/post/utils/post_status.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostRepository postRepository;
  List<PostModel> tempPosts = [];
  PostBloc({required this.postRepository}) : super(const PostState()) {
    on<PostFetchEvent>(_fetchPosts);
    on<SearchPostByEmailEvent>(_searchPostByEmail);
  }

  void _fetchPosts(PostFetchEvent event, Emitter<PostState> emit) async {
    try {
      emit(state.copyWith(
          message: "fetching....", postStatus: PostStatus.loading));
      List<PostModel> posts = await postRepository.fetchPostAPI();
      emit(state.copyWith(
          message: "completed", postStatus: PostStatus.sucess, posts: posts));
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), postStatus: PostStatus.failure));
    }
  }

  void _searchPostByEmail(
      SearchPostByEmailEvent event, Emitter<PostState> emit) {
    if (event.searchKeyword.isEmpty) {
      emit(state.copyWith(tempPosts: [], searchMessage: ''));
    } else {
      tempPosts = state.posts.where((element) {
        return element.email
            .toString()
            .toLowerCase()
            .contains(event.searchKeyword.toLowerCase());
      }).toList();
      if (tempPosts.isEmpty) {
        emit(state.copyWith(tempPosts: [], searchMessage: "No Post Found"));
      } else {
        emit(state.copyWith(tempPosts: tempPosts, searchMessage: ''));
      }
    }
  }
}
