import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';

class DatabaseHelper {
  // create a unique database instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Provide a static getter to access the instance
  static DatabaseHelper get instance => _instance;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  // get database via getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // initialize database
  Future<Database> _initDatabase() async {
    // get database path
    String path = join(await getDatabasesPath(), 'user_database.db');

    // _onCreate create table
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // function to create new tables
  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,  
      username TEXT NOT NULL,  
      password TEXT NOT NULL,  
      email TEXT NOT NULL,  
      gender TEXT,  
      age INTEGER,
      height REAL,  
      weight REAL,  
      goal TEXT
    )
  ''');
    await db.execute('''
    CREATE TABLE workouts (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      steps TEXT NOT NULL,
      time INTEGER
    )
  ''');
    await db.execute('''
    CREATE TABLE meals (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      calories INTEGER
    )
  ''');
    await db.execute('''
    CREATE TABLE progress (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date TEXT NOT NULL,
      calories INTEGER
    )
  ''');
  }

  // insert user data
  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  // get all users
  Future<List<User>> getAllUsers() async {
    Database db = await database;
    final List<Map<String, dynamic>> userMaps = await db.query('users');
    return List.generate(userMaps.length, (i) {
      return User.fromMap(userMaps[i]);
    });
  }

  // get current user
  Future<User?> getCurrentUser(int id) async {
    final db = await database;

    // check user info via id
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }
    return null;
  }

  // verify user login
  Future<User?> validateLogin(String username, String password) async {
    Database db = await database;

    // check username and password
    List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    }

    return null;
  }

  // delete database
  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    await databaseFactory.deleteDatabase(path);
  }

  // update user info into database
  Future<int> updateUser(User user) async {
    final db = await database;

    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }
}
