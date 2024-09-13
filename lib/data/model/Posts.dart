import 'dart:convert';

import 'package:flutter/foundation.dart';

class Posts {
  final List<Post> post;
  Posts({
    required this.post,
  });

  Posts copyWith({
    List<Post>? post,
  }) {
    return Posts(
      post: post ?? this.post,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': post.map((x) => x.toMap()).toList(),
    };
  }

  factory Posts.fromMap(Map<String, dynamic> map) {
    return Posts(
      post: List<Post>.from(
        (map['data'] as List<dynamic>).map<Post>(
          (x) => Post.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Posts.fromJson(String source) =>
      Posts.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Posts(post: $post)';

  @override
  bool operator ==(covariant Posts other) {
    if (identical(this, other)) return true;

    return listEquals(other.post, post);
  }

  @override
  int get hashCode => post.hashCode;
}

class Post {
  final String id;
  final String title;
  final String content;
  final String author;
  final String authorName;
  final List<dynamic> likes;
  final String createdAt;
  final String updatedAt;
  final int v;
  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.authorName,
    required this.likes,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  Post copyWith({
    String? id,
    String? title,
    String? content,
    String? author,
    String? authorName,
    List<dynamic>? likes,
    String? createdAt,
    String? updatedAt,
    int? v,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      author: author ?? this.author,
      authorName: authorName ?? this.authorName,
      likes: likes ?? this.likes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'title': title,
      'content': content,
      'author': author,
      'authorName': authorName,
      'likes': likes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      author: map['author'] as String,
      authorName: map['authorName'] as String,
      likes: List<dynamic>.from((map['likes'] as List<dynamic>)),
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
      v: map['__v'].toInt() as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(_id: $id, title: $title, content: $content, author: $author, authorName: $authorName, likes: $likes, createdAt: $createdAt, updatedAt: $updatedAt, __v: $v)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.author == author &&
        other.authorName == authorName &&
        listEquals(other.likes, likes) &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.v == v;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        author.hashCode ^
        authorName.hashCode ^
        likes.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        v.hashCode;
  }
}
