
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled3/project2/pages/Bloc/appDataBaseState.dart';

class Appdatabaselogic extends Cubit<Appdatabasestate> {
  Appdatabaselogic() : super(Init());
  late int user_id;
late int product_price,product_id;
late String product_name;
  late Database db;
  List<Map> users = [];
  List<Map> products = [];
  List<Map> phones = [];
  List<Map> laptops = [];
  List<Map> tvs = [];
  List cart = [];
  List fav = [];
  List cartProducts = [];
  List favProducts=[];
  List orderProducts=[];
  List orders=[];
  List allOrders=[];
  List user=[];





  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController code = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController imageUrl = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController category = TextEditingController();


  // Method to create database and tables
  Future<void> createDatabaseAndTable() async {
    try {
      db = await openDatabase(
        'us.db',
        version: 22,
        onCreate: (db, version) async {
          print("======== Database Created =====");
          // Create user table
          await db.execute('''
            CREATE TABLE user(
              id INTEGER PRIMARY KEY, 
              name TEXT, 
              email TEXT, 
              password TEXT, 
              url TEXT
            )
          ''');
          await db.execute(
              'create table product(id integer primary key ,name text, price int, description text,product_url text ,category text)');
          // Create product table
          await db.execute(
              'create table favorites(id integer primary key , user_id int, product_id int,Foreign key(user_id) references user(id) , FOREIGN KEY (product_id) REFERENCES product(id))');
          // cart
          await db.execute(
              'create table carts (id integer primary key , user_id int, product_id int,Foreign key(user_id) references user(id) , FOREIGN KEY (product_id) REFERENCES product(id))');
          await db.execute(
              'create table orders (id integer primary key , user_id int, product_id int,cart_id int, total_price int,Foreign key(user_id) references user(id) , FOREIGN KEY (product_id) REFERENCES product(id),FOREIGN KEY (cart_id) REFERENCES carts(id))');

        } ,
        onOpen: (db) {
          print("======= Database Opened ======");
        },
      );
      emit(CreateTables());
      // Load initial data
      await loadInitialData();
    } catch (e) {
      print("Database initialization error: $e");
    }
  }

  Future<void> loadInitialData() async {
    try {
      users = await showData();
      products = await showDataProducts();
      phones = await getAllPhoneProducts();
      laptops = await getAllLaptopProducts();
      tvs = await getAllTvProducts();
      allOrders=await getAllOrders();

      emit(GetUser());
      emit(GetProduct());
      emit(GetPhones());
      emit(GetLaptops());
      emit(GetTV());
      emit(GetOrders());


    } catch (e) {
      print("Error loading initial data: $e");
    }
  }
  Future<void> createDatabaseAndTables(int id) async {
    try {
      db = await openDatabase(
        'us.db',
        version: 22,
        onCreate: (db, version) async {
          print("======== Database Created =====");
          // Create user table
          await db.execute('''
            CREATE TABLE user(
              id INTEGER PRIMARY KEY, 
              name TEXT, 
              email TEXT, 
              password TEXT, 
              url TEXT
            )
          ''');
          await db.execute(
              'create table product(id integer primary key ,name text, price int, description text,product_url text ,category text)');
          // Create product table
          await db.execute(
              'create table favorites(id integer primary key , user_id int, product_id int,Foreign key(user_id) references user(id) , FOREIGN KEY (product_id) REFERENCES product(id))');
          // cart
          await db.execute(
              'create table carts (id integer primary key , user_id int, product_id int,Foreign key(user_id) references user(id) , FOREIGN KEY (product_id) REFERENCES product(id))');
          await db.execute(
              'create table orders (id integer primary key , user_id int, product_id int,cart_id int, total_price int,Foreign key(user_id) references user(id) , FOREIGN KEY (product_id) REFERENCES product(id),FOREIGN KEY (cart_id) REFERENCES carts(id))');

        } ,
        onOpen: (db) {
          print("======= Database Opened ======");
        },
      );
      emit(CreateTables());
      // Load initial data
      await loadInitialDatas(id);
    } catch (e) {
      print("Database initialization error: $e");
    }
  }

  Future<void> loadInitialDatas(int id) async {
    try {
      users = await showData();
      products = await showDataProducts();
      phones = await getAllPhoneProducts();
      laptops = await getAllLaptopProducts();
      tvs = await getAllTvProducts();
       cart = await getCart(id);
      fav = await getFavorites(id);
      cartProducts = await getCartProducts(id);
      favProducts = await getFavProducts(id);
       await getOrdersByUserId(id);
      user= await showUser(id);

      emit(GetUser());
      emit(GetProduct());
      emit(GetPhones());
      emit(GetLaptops());
      emit(GetTV());
      emit(GetOrders());

    } catch (e) {
      print("Error loading initial data: $e");
    }
  }


  Future<void> delteDatabase() async {
    try {
      await deleteDatabase('us.db');
    } catch (e) {
      print("Error deleting database: $e");
    }
  }

   insertUser({
    required String name,
    required String email,
    required String pass,
    required String url,
  }) {
    db.transaction((txn) async {
      txn.rawInsert(
        'insert into user (name,email,password,url)'
            ' values ("$name","$email","$pass","$url")',
      )
          .then((value) {
        print('inserted row $value');
        user_id=value;
        emit(AddUser());
        emit(UserId());

      }).catchError((e) {
        print(e);
      });
    });
    emit(UserId());

  }
  

  Future<void> updateProduct({
    required int code,
    required String name,
    required int price,
    required String description,
    required String url,
    required String category,

  }) async {
    if (db == null) {
      print("Database is not initialized.");
      return;
    }
    try {
      await db.transaction((data) async {
        await data.rawUpdate('''
          UPDATE product 
          SET name = ?, price = ?, description = ?, product_url = ? , category = ?
          WHERE id = ?
        ''', [name, price, description, url,category, code]);
        emit(UpdateProduct());
      });
    } catch (e) {
      print("Error updating product: $e");
    }
  }

  Future<List<Map>> showData() async {
    if (db == null) {
      print("Database is not initialized.");
      return [];
    }
    try {
      return await db.rawQuery("SELECT * FROM user");
    } catch (e) {
      print("Error fetching user data: $e");
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> showUser(int userId) async {
    if (db == null) {
      print("Database is not initialized.");
      return [];
    }

    try {
      List<Map<String, dynamic>> result = await db.rawQuery(
        "SELECT * FROM user WHERE id = ?",
        [userId],
      );
      return result;
    } catch (e) {
      print("Error fetching user data: $e");
      return [];
    }
  }

  Future<List<Map>> showDataProducts() async {
    if (db == null) {
      print("Database is not initialized.");
      return [];
    }
    try {
      return await db.rawQuery("SELECT * FROM product");
    } catch (e) {
      print("Error fetching product data: $e");
      return [];
    }
  }


  Future<void> addProduct({
    required int code,
    required String name,
    required int price,
    required String description,
    required String url,
    required String category,
  }) async {
    if (db == null) {
      print("Database is not initialized.");
      return;
    }
    try {
      await db.transaction((txn) async {
        await txn.rawInsert('''
          INSERT INTO product (id, name, price, description, product_url,category) 
          VALUES (?, ?, ?, ?, ?, ?)
        ''', [code, name, price, description, url,category]);
        emit(AddProduct());
      });
    } catch (e) {
      print("Error adding product: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    if (db == null) {
      print("Database is not initialized.");
      return [];
    }
    try {
      return await db.query('product');
    } catch (e) {
      print("Error fetching products: $e");
      return [];
    }
  }

  Future<int> addToCart(int userId, int productId) async {
    if (db == null) {
      print("Database is not initialized.");
      return 0;
    }
    try {
      var result = await db.insert('carts', {
        'user_id': userId,
        'product_id': productId,
      });
      emit(AddToCart());
      return result;
    } catch (e) {
      print("Error adding to cart: $e");
      return 0;
    }
  }
  Future<void> placeOrder(int userId,double total_price) async {
    final cartProducts = await db.query(
      'carts',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    emit(GetCart());


    await db.insert(
      'orders',
      {
        'user_id': userId,
        'product_id': cartProducts.map((p) => p['product_id']).join(','),
        'cart_id': cartProducts.map((p) => p['id']).join(','),
        'total_price': total_price,
      },

    );
    emit(MakeOrder());

    // Clear the cart after the order is placed
    await db.delete('carts', where: 'user_id = ?', whereArgs: [userId]);
    emit(DeleteFromCart());
    createDatabaseAndTables(userId);
    emit(CreateTables());
  }

  Future<List<Map<String, dynamic>>> getCart(int userId) async {
    if (db == null) {
      print("Database is not initialized.");
      return [];
    }
    try {
      var result = await db.query('carts', where: 'user_id = ?', whereArgs: [userId]);
      cart=result;
      emit(GetCart());

      return result;
    } catch (e) {
      print("Error fetching cart: $e");
      return [];
    }
  }

  Future<int> addToFavorites(int userId, int productId) async {
    if (db == null) {
      print("Database is not initialized.");
      return 0;
    }
    try {
      var result = await db.insert('favorites', {
        'user_id': userId,
        'product_id': productId,
      });
      emit(AddToFav());
      return result;
    } catch (e) {
      print("Error adding to favorites: $e");
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getFavorites(int userId) async {
    if (db == null) {
      print("Database is not initialized.");
      return [];
    }
    try {
      var result = await db.query('favorites', where: 'user_id = ?', whereArgs: [userId]);
     fav=result;
      emit(GetFavourites());

      return result;
    } catch (e) {
      print("Error fetching favorites: $e");
      return [];
    }
  }
// Delete a product from the cart
  Future<void> deleteProductFromCart(int userId, int productId) async {
    await db.delete('carts', where: 'user_id = ? AND product_id = ?', whereArgs: [userId, productId]);
    await  createDatabaseAndTables(userId);

    emit(DeleteFromCart());

  }

// Delete a product from the favorites database
  Future<void> deleteProductFromFavorites(int userId, int productId) async {
    await db.delete('favorites', where: 'user_id = ? AND product_id = ?', whereArgs: [userId, productId]);
    await  createDatabaseAndTables(userId);

    emit(DeleteFromFavorite());

  }

  void showProductDetails() {
    if (db == null) {
      print("Database is not initialized.");
      return;
    }
    for (int i = 0; i < products.length; i++) {
      if (int.parse(id.text) == products[i]['id']) {
        name.text = products[i]['name'];
        price.text = products[i]['price'].toString();
        code.text = products[i]['id'].toString();
        imageUrl.text = products[i]['product_url'];
        description.text = products[i]['description'];
        category.text = products[i]['category'];

        break;
      }
    }
    emit(ShowProductDetails());
  }

  void showProductsDetails() {
    if (db == null) {
      print("Database is not initialized.");
      return;
    }
    for (int i = 0; i < products.length; i++) {
      if (product_id == products[i]['id']) {
        product_name= products[i]['name'];
        product_price = products[i]['price'];

        break;
      }
    }
    emit(ShowProductsDetails());
  }

  void deleteAllProducts() {
    db.delete('product').then((value) {
      emit(DeleteAllProductsState());
    }).catchError((e) {
      print(e);
    });
  }
 void deleteAllUsers() async {
    await db.delete('user'); // Deletes all rows in the 'user' table
    emit(DeleteUsers());
  }

  Future<List<Map<String, dynamic>>> getAllLaptopProducts() async {
    return await db.query(
      'product',
      where: 'category = ?',
      whereArgs: ['Laptop'],
    );
  }
  Future<List<Map<String, dynamic>>> getAllPhoneProducts() async {

    return await db.query(
      'product',
      where: 'category = ?',
      whereArgs: ['Phone'],
    );
  }

  Future<List<Map<String, dynamic>>> getAllTvProducts() async {
    return await db.query(
      'product',
      where: 'category = ?',
      whereArgs: ['TV'],
    );
  }
Future<bool> validateUser(String email, String password) async {
  var result = await db.rawQuery(
    'SELECT * FROM user WHERE email = ? AND password = ?',
    [email, password],
  );
  return result.isNotEmpty;
}
Future<List<Map<String, dynamic>>> getUsers() async {
    return await db.query('user');
  }

  Future<List<Map<String, dynamic>>> getCartProducts(int userId) async {


    // Query the carts table to get the product IDs for the given user ID
    final cartItems = await db.query(
      'carts',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    emit(GetCart());

    // Create a list of product IDs from the cart items
    final productIds = cartItems.map((item) => item['product_id'] as int).toList();

    // Query the products table to get the product details for the product IDs in the cart
    final products = await db.query(
      'product',
      where: 'id IN (${productIds.join(', ')})',
    );
    cartProducts=products;
    emit(GetCartProducts());

    return products;
  }


  Future<List<Map<String, dynamic>>> getFavProducts(int userId) async {


    // Query the carts table to get the product IDs for the given user ID
    final cartItems = await db.query(
      'favorites',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    emit(GetFavourites());

    // Create a list of product IDs from the cart items
    final productIds = cartItems.map((item) => item['product_id'] as int).toList();

    // Query the products table to get the product details for the product IDs in the cart
    final products = await db.query(
      'product',
      where: 'id IN (${productIds.join(', ')})',
    );
    favProducts=products;

    emit(GetFavProducts());
    return products;
  }

  Future<List<Map<String, dynamic>>> getOrdersByUserId(int userId) async {
    final result= await db.query(
      'orders',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    orders= result;
    emit(GetOrders());
return result;

  }

  Future<List<Map<String, dynamic>>> getAllOrders() async {
    final orderResults = await db.rawQuery('select * from orders');
    allOrders=orderResults;
    emit(GetOrders());
    return orderResults;

}

}
