import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_test/features/posts/data/models/post_model/post_model.dart';
import 'package:test_test/features/posts/data/repositories/post_repository.dart';
import 'package:test_test/features/posts/presentation/bloc/bloc/post_bloc.dart';
import 'package:test_test/features/posts/presentation/bloc/event/post_event.dart';
import 'package:test_test/features/posts/presentation/bloc/state/post_state.dart';

import 'bloc_test.mocks.dart';

@GenerateMocks([PostRepository])
void main() {
  late PostBloc postBloc;
  late MockPostRepository mockPostRepository;

  setUp(() {
    mockPostRepository = MockPostRepository();
    postBloc = PostBloc(mockPostRepository);
  });

  tearDown(() {
    postBloc.close();
  });

  test("initial state of the post bloc should be initial state", () {
    expect(postBloc.state, const PostState.initial());
  });

  blocTest<PostBloc, PostState>(
    'emits [PostState.loading, PostState.loaded] when fetchPosts is successful',
    build: () {
      when(mockPostRepository.fetchPosts()).thenAnswer(
          (_) async => [const Post(id: 1, title: 'Test', body: 'Test body')]);
      return postBloc;
    },
    act: (bloc) => bloc.add(const PostEvent.fetchPosts()),
    expect: () => const <PostState>[
      PostState.loading(),
      PostState.loaded([Post(id: 1, title: 'Test', body: 'Test body')]),
    ],
  );

  blocTest(
    'emits [PostState.loading, PostState.error] when fetchPosts fails',
    build: () {
      when(mockPostRepository.fetchPosts())
          .thenThrow(Exception('Failed to fetch posts'));
      return postBloc;
    },
    act: (bloc) => bloc.add(const PostEvent.fetchPosts()),
    expect: () => const <PostState>[
      PostState.loading(),
      PostState.error('Failed to fetch posts'),
    ],
  );
}
