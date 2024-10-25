class User {
  final int? id;
  final String username;
  final String password;
  final String email;
  final String gender;
  final int age;
  final double? height;
  final double? weight;
  final String? goal;

  // constructor
  User({
    this.id,
    required this.username,
    required this.password,
    required this.email,
    required this.gender,
    required this.age,
    this.height,
    this.weight,
    this.goal,
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
      'height': height,
      'weight': weight,
      'goal': goal,
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
      height: map['height'] != null ? map['height'] as double : null,
      weight: map['weight'] != null ? map['weight'] as double : null,
      goal: map['goal'],
    );
  }

  // Copy method for updating User object
  User copyWith({
    int? id,
    String? username,
    String? password,
    String? email,
    String? gender,
    int? age,
    double? height,
    double? weight,
    String? goal,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      goal: goal ?? this.goal,
    );
  }
}