import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_travel_booking/model/post.dart';

class PostProvider extends StateNotifier<Post?> {
  PostProvider() : super(null);

  Post? _currentPost;

  // G E T T E R
  Post? get currentPost => _currentPost;

  // S E T T E R
  Future<void> savePost(Post post) async {
    _currentPost = post;
  }

}

final postProvider = StateNotifierProvider<PostProvider, Post?>((ref) => PostProvider());
