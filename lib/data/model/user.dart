import 'dart:convert';

class User {
  final Data data;
  User({
    required this.data,
  });

  User copyWith({
    Data? data,
  }) {
    return User(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      data: Data.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(data: $data)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.data == data;
  }

  @override
  int get hashCode => data.hashCode;
}

class Data {
  final String name;
  final String email;
  final String id;
  Data({
    required this.name,
    required this.email,
    required this.id,
  });

  Data copyWith({
    String? name,
    String? email,
    String? id,
  }) {
    return Data(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'id': id,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      name: map['name'] as String,
      email: map['email'] as String,
      id: map['id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Data(name: $name, email: $email, id: $id)';

  @override
  bool operator ==(covariant Data other) {
    if (identical(this, other)) return true;

    return other.name == name && other.email == email && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ id.hashCode;
}
