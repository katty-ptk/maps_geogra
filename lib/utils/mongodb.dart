// ignore_for_file: avoid_print

import 'dart:developer';

import 'constant.dart';

import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);

    await db.open();
    inspect(db);

    var collection = db.collection(COLLECTION_NAME);

    // INSERT TO DATABASE
    await collection.insertMany([
      {
        "username": "katty_ptk",
        "name": "Ecaterina Patkany",
        "email": "katy.lazar05@gmail.com"
      },
    
      {
        "username": "hitest",
        "name": "Testul Meu",
        "email": "testul.meu206@gmail.com"
      },   
    ]);


    print(await collection.find().toList());

    // UPDATE DATABASE
    await collection.updateMany(
      where.eq('username', 'katty_ptk'), 
      modify.set('name', 'PATKANY E.')
    );

    print(await collection.find().toList());

    // DELETE FROM DATABASE
    await collection.deleteMany({"username": "hitest"});
    await collection.deleteMany({"username": "katty_ptk"});

    print(await collection.find().toList());
  }
}