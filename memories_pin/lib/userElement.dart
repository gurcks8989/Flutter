class UserElement {
  const UserElement({
    required this.userId,
    required this.name,
    required this.email,
    required this.statusMessage,
    required this.path,
  });

  final String userId ;
  final String name ;
  final String email ;
  final String statusMessage ;
  final String path ;

  static UserElement reset() {
    return const UserElement(
      userId: '',
      name: '',
      email: '',
      statusMessage: '',
      path: '',
    );
  }
}