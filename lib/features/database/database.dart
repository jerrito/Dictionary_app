// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:riverpod_learn/features/database/entity/dicitionary.dart';
import 'package:riverpod_learn/features/database/entity/dictionary_type_conveter.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/word_dao.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [DictionaryResponse])
@TypeConverters([DictionaryResponseConveter])
abstract class AppDatabase extends FloorDatabase {
  WordDao get wordDao;
}
