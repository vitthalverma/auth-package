class UserEntity {
  final String id;
  final String email;
  String? displayName;
  String? photoURL;
  bool? emailVerified;

  UserEntity({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    this.emailVerified,
  });
}
