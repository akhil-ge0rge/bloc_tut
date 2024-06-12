part of 'post_bloc.dart';

class PostState extends Equatable {
  final PostStatus postStatus;
  final List<PostModel> posts;
  final List<PostModel> tempPosts;
  final String message;
  final String searchMessage;
  const PostState(
      {this.postStatus = PostStatus.loading,
      this.posts = const <PostModel>[],
      this.tempPosts = const <PostModel>[],
      this.message = '',
      this.searchMessage = ''});

  PostState copyWith({
    PostStatus? postStatus,
    List<PostModel>? posts,
    List<PostModel>? tempPosts,
    String? message,
    String? searchMessage,
  }) {
    return PostState(
        message: message ?? this.message,
        postStatus: postStatus ?? this.postStatus,
        posts: posts ?? this.posts,
        tempPosts: tempPosts ?? this.tempPosts,
        searchMessage: searchMessage ?? this.searchMessage);
  }

  @override
  List<Object> get props =>
      [postStatus, posts, message, tempPosts, searchMessage];
}
