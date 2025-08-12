import 'package:flutter_project_food_delivery_david/model/food.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// adjust if your model is in a different path

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('food_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE food (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        imageUrl TEXT,
        price REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE cart (
        id TEXT PRIMARY KEY,
        foodId TEXT,
        quantity INTEGER,
        FOREIGN KEY (foodId) REFERENCES food (id)
      )
    ''');

    // Insert 5 sample foods
    List<Food> initialFoods = [
      Food(
        id: '1',
        name: 'Burger',
        description: 'A delicious beef burger',
        imageUrl: 'https://www.foodandwine.com/thmb/DI29Houjc_ccAtFKly0BbVsusHc=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/crispy-comte-cheesburgers-FT-RECIPE0921-6166c6552b7148e8a8561f7765ddf20b.jpg',
        price: 25.0,
      ),
      Food(
        id: '2',
        name: 'Pizza',
        description: 'Cheesy pepperoni pizza',
        imageUrl: 'https://media.istockphoto.com/id/938742222/id/foto/cheesy-pepperoni-pizza.jpg?s=612x612&w=0&k=20&c=OPCB6cvr8E8m6rtFX75WG-s8T3aXBqGbpTQ3U5iD65s=',
        price: 35.0,
      ),
      Food(
        id: '3',
        name: 'Pasta',
        description: 'Creamy carbonara pasta',
        imageUrl: 'https://www.allrecipes.com/thmb/IrY572TXic4UXXVn8EetsarI3S0=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/AR-269500-creamy-garlic-pasta-Beauties-4x3-f404628aad2a435a9985b2cf764209b5.jpg',
        price: 28.0,
      ),
      Food(
        id: '4',
        name: 'Salad',
        description: 'Healthy mixed salad',
        imageUrl: 'https://images.immediate.co.uk/production/volatile/sites/30/2014/05/Epic-summer-salad-hub-2646e6e.jpg',
        price: 18.0,
      ),
      Food(
        id: '5',
        name: 'Sushi',
        description: 'Fresh salmon sushi',
        imageUrl: 'https://res.cloudinary.com/jnto/image/upload/w_1440,h_900,c_fill,f_auto,fl_lossy,q_60/v1/media/filer_public/47/7f/477f36c3-a329-437d-a571-d75cdaa73a6f/1_5_zv5jq9',
        price: 40.0,
      ),
    ];

    for (var food in initialFoods) {
      await db.insert('food', food.toJson());
    }
  }

  Future<List<Food>> getAllFoods() async {
    final db = await instance.database;
    final result = await db.query('food');
    return result.map((json) => Food.fromJson(json)).toList();
  }

  Future<Food?> getFoodById(String id) async {
    final db = await instance.database;
    final result = await db.query(
      'food',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return Food.fromJson(result.first);
    } else {
      return null;
    }
  }

  Future<void> addToCart(Food food, int quantity) async {
    final db = await instance.database;
    final cartItem = {
      'id': food.id,
      'foodId': food.id,
      'quantity': quantity,
    };
    await db.insert('cart', cartItem, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getCartItems() async {
    final db = await instance.database;
    return await db.query('cart');
  }
}