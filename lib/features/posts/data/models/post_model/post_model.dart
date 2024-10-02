import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required int id,
    required String title,
    required String body,
  }) = _Post;

  // Add this factory to generate a Post from a JSON map
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
