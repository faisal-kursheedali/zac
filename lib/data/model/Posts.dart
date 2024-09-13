/// post : [{"_id":"66e3bc715e96ec180aac63f5","title":"heyy kkwkjjnjhojhjrld","content":"unknknjhnjjhuhuhkkmhjukj jhbj ... ","author":"66e341dac3dcd943b41d30b6","likes":[],"createdAt":"2024-09-13T04:15:45.966Z","updatedAt":"2024-09-13T04:15:45.966Z","__v":0}]

class Posts {
  Posts({
    this.post,
  });

  Posts.fromJson(dynamic json) {
    if (json['post'] != null) {
      post = [];
      json['post'].forEach((v) {
        post?.add(Post.fromJson(v));
      });
    }
  }
  List<Post>? post;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (post != null) {
      map['post'] = post?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "66e3bc715e96ec180aac63f5"
/// title : "heyy kkwkjjnjhojhjrld"
/// content : "unknknjhnjjhuhuhkkmhjukj jhbj ... "
/// author : "66e341dac3dcd943b41d30b6"
/// likes : []
/// createdAt : "2024-09-13T04:15:45.966Z"
/// updatedAt : "2024-09-13T04:15:45.966Z"
/// __v : 0

class Post {
  Post({
    this.id,
    this.title,
    this.content,
    this.author,
    this.likes,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Post.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    content = json['content'];
    author = json['author'];
    if (json['likes'] != null) {
      likes = [];
      json['likes'].forEach((v) {
        likes?.add(v);
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  String? title;
  String? content;
  String? author;
  List<dynamic>? likes;
  String? createdAt;
  String? updatedAt;
  num? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['content'] = content;
    map['author'] = author;
    if (likes != null) {
      map['likes'] = likes?.map((v) => v.toJson()).toList();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}
