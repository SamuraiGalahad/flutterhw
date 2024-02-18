import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

@freezed
class News with _$News {
  factory News({
    required String id,
    required String name,
    required String author,
    required String title,
    required String description,
    required String url,
    required String urlToImage,
    required String publishedAt,
    required String content,
  }) = _News;
  @override
  String toString() => '$name (id=$id)';

  factory News.fromJson(Map<String, dynamic> json) =>
     _$NewsFromJson(json);
}
