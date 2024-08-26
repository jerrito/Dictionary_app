// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WordDao? _wordDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `DictionaryResponse` (`id` INTEGER, `dictionary` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WordDao get wordDao {
    return _wordDaoInstance ??= _$WordDao(database, changeListener);
  }
}

class _$WordDao extends WordDao {
  _$WordDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _dictionaryResponseInsertionAdapter = InsertionAdapter(
            database,
            'DictionaryResponse',
            (DictionaryResponse item) => <String, Object?>{
                  'id': item.id,
                  'dictionary':
                      _dictionaryResponseConveter.encode(item.dictionary)
                },
            changeListener),
        _dictionaryResponseDeletionAdapter = DeletionAdapter(
            database,
            'DictionaryResponse',
            ['id'],
            (DictionaryResponse item) => <String, Object?>{
                  'id': item.id,
                  'dictionary':
                      _dictionaryResponseConveter.encode(item.dictionary)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DictionaryResponse>
      _dictionaryResponseInsertionAdapter;

  final DeletionAdapter<DictionaryResponse> _dictionaryResponseDeletionAdapter;

  @override
  Stream<List<DictionaryResponse>> getList() {
    return _queryAdapter.queryListStream('SELECT * FROM DictionaryResponse',
        mapper: (Map<String, Object?> row) => DictionaryResponse(
            id: row['id'] as int?,
            dictionary: _dictionaryResponseConveter
                .decode(row['dictionary'] as String)),
        queryableName: 'DictionaryResponse',
        isView: false);
  }

  @override
  Future<DictionaryResponse?> getDictionaryResponse(int id) async {
    return _queryAdapter.query('SELECT * FROM DictionaryResponse WHERE id= ?1',
        mapper: (Map<String, Object?> row) => DictionaryResponse(
            id: row['id'] as int?,
            dictionary: _dictionaryResponseConveter
                .decode(row['dictionary'] as String)),
        arguments: [id]);
  }

  @override
  Future<void> insertData(DictionaryResponse response) async {
    await _dictionaryResponseInsertionAdapter.insert(
        response, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDictionaryResponse(DictionaryResponse response) async {
    await _dictionaryResponseDeletionAdapter.delete(response);
  }

  @override
  Future<void> deleteListDictionaryResponse(
      List<DictionaryResponse> list) async {
    await _dictionaryResponseDeletionAdapter.deleteList(list);
  }
}

// ignore_for_file: unused_element
final _dictionaryResponseConveter = DictionaryResponseConveter();
