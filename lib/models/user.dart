class User {
  final int? id;
  final String username;
  final String password;
  final String email;
  final String gender;
  final int age;

  // constructor
  User({
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.gender,
    required this.age,
  });

  // User => Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'gender': gender,
      'age': age,
    };
  }

  // Map => User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
      gender: map['gender'],
      age: map['age'],
    );
  }
}
