import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/post_model/post_model.dart';

part 'post_state.freezed.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial() = _Initial;
  const factory PostState.loading() = _Loading;
  const factory PostState.loaded(List<Post> posts) = _Loaded;
  const factory PostState.error(String message) = _Error;
}
