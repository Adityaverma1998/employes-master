class User {
  final String uid;
  final String email;

  User({required this.uid, required this.email});

  User copyWith({String? uid, String? email}) {
    return User(uid: uid ?? this.uid, email: email ?? this.email);
  }
}
