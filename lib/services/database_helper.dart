import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../services/event.dart';

class DatabaseHelper {
  // create a unique database instance
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  // Provide a static getter to access the instance
  // static DatabaseHelper get instance => _instance;

  factory DatabaseHelper() {
    return instance;
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
    String path = join(await getDatabasesPath(), 'user_database.db');
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
        weight REAL,
        height REAL,
        goal TEXT 
      )
    ''');
    await db.execute('''
      CREATE TABLE events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workoutName TEXT,
        workoutMuscle TEXT,
        met REAL,
        day INTEGER,
        month INTEGER,
        year INTEGER,
        totalCalories INTEGER,
        caloriesBurned REAL
      )
    ''');
  }

  // Insert user data
  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert('users', user.toMap());
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final Database database = await instance.database;
    return database.query('users');
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

  // Verify user login
  Future<User?> validateLogin(String username, String password) async {
    Database db = await database;
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

  // Insert event
  Future<int> insertEvent(Event event) async {
    Database db = await database;
    return await db.insert('events', event.toMap());
  }

  Future<bool> doesNullEventExist(
      String workoutName, String workoutMuscle) async {
    final db = await instance.database;
    final result = await db.query(
      'events',
      where: 'workoutName = ? AND workoutMuscle = ?',
      whereArgs: [workoutName, workoutMuscle],
    );
    return result.isNotEmpty;
  }

  Future<bool> doesEventExist(String workoutName, String workoutMuscle, int day,
      int month, int year) async {
    final db = await instance.database;
    final result = await db.query(
      'events',
      where:
          'workoutName = ? AND workoutMuscle = ? AND day = ? AND month = ? AND year = ?',
      whereArgs: [workoutName, workoutMuscle, day, month, year],
    );
    return result.isNotEmpty;
  }

  Future<String> getUserInfo(String choice) async {
    final Database database = await instance.database;
    List<Map<String, Object?>> users = await database.query('users');
    Map<String, dynamic> user = users[0];
    switch (choice) {
      case 'name':
        return user['name'].toString();
      case 'weight':
        return user['weight'].toString();
      case 'height':
        return user['height'].toString();
      case 'age':
        return user['age'].toString();
      case 'gender':
        return user['gender'].toString();
      case 'goal':
        return user['goal'].toString();
      default:
        return "";
    }
  }

  // Query all events
  Future<List<Map<String, dynamic>>> queryAllEvents() async {
    Database db = await database;
    return await db.query('events');
  }

  // Query event by ID
  Future<List<Event>?> queryEvent(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> maps =
        await db.query('events', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return maps.map((e) => Event.fromMap(e)).toList();
    }
    return null;
  }

  // delete database
  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    await databaseFactory.deleteDatabase(path);
  }

  // Query events for a specific day
  Future<List<Map<String, dynamic>>> queryEventsforDay(
      int day, int month, int year) async {
    Database db = await database;
    return await db.query(
      'events',
      where: 'day = ? AND month = ? AND year = ?',
      whereArgs: [day, month, year],
    );
  }

  // Get total calories for a day
  Future<int> getCaloriesForDay(int day, int month, int year) async {
    int totalCalories = 0;
    final events = await queryEventsforDay(day, month, year);
    if (events.isNotEmpty) {
      for (final event in events) {
        totalCalories = Event.fromMap(event).totalCalories;
      }
    }
    return totalCalories;
  }

  // Set total calories for a day
  Future<void> setCaloriesForDay(
      int day, int month, int year, int newCalories) async {
    final events = await queryEventsforDay(day, month, year);
    for (final event in events) {
      await updateCalories(Event.fromMap(event), day, month, year, newCalories);
    }
  }

  // Update calories for a specific day
  Future<int> updateCalories(
      Event event, int day, int month, int year, int newCalories) async {
    final db = await database;
    return await db.update('events', {'totalCalories': newCalories},
        where: 'day = ? AND month = ? AND year = ?',
        whereArgs: [day, month, year]);
  }

  Future<void> incrementCaloriesForDay(
      int day, int month, int year, int incrementAmount) async {
    int oldCalories = await getCaloriesForDay(day, month, year);
    int newCalories = oldCalories + incrementAmount;
    await setCaloriesForDay(day, month, year, newCalories);
  }

  // Get calories burned for a workout
  Future<double> getCaloriesBurnedForWorkout(String workoutName,
      String workoutMuscle, int day, int month, int year) async {
    double caloriesBurned = 0;
    final events =
        await queryWorkout(workoutName, workoutMuscle, day, month, year);
    if (events.isNotEmpty) {
      for (final event in events) {
        caloriesBurned = Event.fromMap(event).caloriesBurned;
      }
    }
    return caloriesBurned;
  }

  // Set calories burned for a workout
  Future<void> setCaloriesBurnedForWorkout(
      String workoutName,
      String workoutMuscle,
      int day,
      int month,
      int year,
      double newCaloriesBurned) async {
    final events = await queryEventsforDay(day, month, year);
    for (final event in events) {
      await updateCaloriesBurned(Event.fromMap(event), workoutName,
          workoutMuscle, day, month, year, newCaloriesBurned);
    }
  }

  // Query workout by day
  Future<List<Map<String, dynamic>>> queryWorkout(String workoutName,
      String workoutMuscle, int day, int month, int year) async {
    Database db = await database;
    return await db.query('events',
        where:
            'workoutName = ? AND workoutMuscle = ? AND day = ? AND month = ? AND year = ?',
        whereArgs: [workoutName, workoutMuscle, day, month, year]);
  }

  // Update calories burned for a workout
  Future<int> updateCaloriesBurned(
      Event event,
      String workoutName,
      String workoutMuscle,
      int day,
      int month,
      int year,
      double newCaloriesBurned) async {
    final db = await database;
    return await db.update('events', {'caloriesBurned': newCaloriesBurned},
        where:
            'workoutName = ? AND workoutMuscle = ? AND day = ? AND month = ? AND year = ?',
        whereArgs: [workoutName, workoutMuscle, day, month, year]);
  }
}
