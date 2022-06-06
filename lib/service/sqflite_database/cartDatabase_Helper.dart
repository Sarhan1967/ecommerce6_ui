import 'package:e_commerce/constants.dart';
import 'package:e_commerce/model/cart_product_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//class DatabaseHelper {
class CartDatbaseHelper {
//single tone--------
  //DatabaseHelper();
  CartDatbaseHelper._();

  //instance-------------
  static final CartDatbaseHelper db = CartDatbaseHelper._();

//instance from sqflite db----------
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  //when -database=null create new one(initDb)---------
  initDB() async {
    //path of database'CartProduct.db' in the mobile---
    String path = join(await getDatabasesPath(), 'cartProducts.db');
    //_database = await openDatabase(
    return await openDatabase(path, version: 1,
      onCreate: (Database database, int version) async {
        print('database created.......');
        await database.execute(''' CREATE TABLE $cartTableName( 
            $cartProductName TEXT NOT NULL,
             $cartProductImage TEXT NOT NULL, 
             $cartProductPrice TEXT NOT NULL, 
             $cartProductQuantity INTEGER NOT NULL , 
             $cartProductId TEXT NOT NULL )''');
        print(' $cartTableName table created.......');

/*        await database.execute(''' CREATE TABLE $favTableName(
            $favProductName TEXT NOT NULL,
             $favProductImage TEXT NOT NULL,
             $favProductPrice TEXT NOT NULL,
             $favProductDescription TEXT NOT NULL,
             $favProductId TEXT NOT NULL )''');
        print(' $favTableName table created.......');*/
      },
    );
  }

  Future<List<CartProductModel>?> getAllProduct() async {
    //var dbClient = await (database as FutureOr<Database>);
    var dbClient = await database;
    //List<Map> maps = (await dbClient?.query(tableCartProduct)).cast<Map>();
    List<Map>? maps = (await dbClient?.query(cartTableName))?.cast<Map>();
    //List<CartProductModel>? list = maps?.isNotEmpty as List<CartProductModel>?;
    List<CartProductModel>? list = maps!.isNotEmpty
        ? maps.map((product) => CartProductModel.fromJson(product)).toList()
        : [];
    return list;
  }

  insert(CartProductModel model) async {
    var clientDb = await database;
    await clientDb?.insert(cartTableName, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(' product inserted.......');
  }


  // Future<List<CartProductModel>?> getAllCartProducts() async {
  //   var clientDb = await database;
  //   List<Map>? maps = (await clientDb?.query(cartTableName))?.cast<Map>();
  //   List<CartProductModel>? list = maps!.isNotEmpty
  //       ? maps.map((cartProduct) => CartProductModel.fromJson(cartProduct)).toList()
  //       : [];
  //   return list;
  // }

/*  getAllFavoriteProducts() async {
    var clientDb = await database;
    List<Map> favoriteProductsList = await clientDb!.query(favTableName);
    List<FavoritesProductModel> allFavProducts = favoriteProductsList.isNotEmpty
        ? favoriteProductsList
        .map((favProduct) => FavoritesProductModel.fromJson(favProduct))
        .toList()
        : [];

    return allFavProducts;
  }*/

  update(CartProductModel model) async {
    var clientDB = await database;
    return await clientDB?.update(cartTableName, model.toJson(),
        where: ' $cartProductId = ?', whereArgs: ['${model.productId}']);
  }

  deleteProductFromCart(String proId) async {
    var clientDB = await database;
    return await clientDB?.delete('$cartTableName',
        where: '$cartProductId = ?', whereArgs: [proId]);
  }

/*  deleteProductFromFavorites(String proId) async {
    var clientDB = await database;
    await clientDB?.delete('$favTableName',
        where: '$favProductId = ?', whereArgs: [proId]);
  }*/

  deleteAllCartProducts() async {
    var clientDB = await database;
    return await clientDB?.rawDelete('DELETE FROM $cartTableName');
  }
}
