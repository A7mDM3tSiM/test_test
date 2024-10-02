import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/post_repository.dart';
import '../event/post_event.dart';
import '../state/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(const PostState.initial()) {
    on<PostEvent>((event, emit) async {
      event.when(fetchPosts: () => _fetchPosts(emit));
    });
  }

  Future<void> _fetchPosts(Emitter<PostState> emit) async {
    emit(const PostState.loading());
    try {
      final posts = await postRepository.fetchPosts();
      emit(PostState.loaded(posts));
    } catch (e) {
      emit(const PostState.error('Failed to fetch posts'));
    }
  }
}
