// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  ClienteDao? _clienteDaoInstance;

  UsuarioDao? _usuarioDaoInstance;

  EstadoDao? _estadoDaoInstance;

  MedidorDao? _medidorDaoInstance;

  MedicionDao? _medicionDaoInstance;

  NuevaMedicionDao? _nuevamedicionDaoInstance;

  DemandaDao? _demandaDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `Cliente` (`cuenta_id` TEXT NOT NULL, `cedula` TEXT NOT NULL, `nombre` TEXT NOT NULL, `apellido` TEXT NOT NULL, `direccion` TEXT NOT NULL, `celular` TEXT NOT NULL, `valor` REAL NOT NULL, `planillas` INTEGER NOT NULL, PRIMARY KEY (`cuenta_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Usuario` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `usuario` TEXT NOT NULL, `clave` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Estado` (`codigo` TEXT NOT NULL, `descripcion` TEXT NOT NULL, PRIMARY KEY (`codigo`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Medidor` (`num_medidor` TEXT NOT NULL, `esferas` INTEGER NOT NULL, `coordenada_x` REAL NOT NULL, `coordenada_y` REAL NOT NULL, `secuencia` INTEGER NOT NULL, `ruta` INTEGER NOT NULL, `sector` INTEGER NOT NULL, `zona` TEXT, `bloque` INTEGER NOT NULL, `demanda_facturable` REAL, `cuenta_id` TEXT NOT NULL, FOREIGN KEY (`cuenta_id`) REFERENCES `Cliente` (`cuenta_id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`num_medidor`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Medicion` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `lectura_anterior` INTEGER NOT NULL, `consumo_promedio` INTEGER NOT NULL, `tipo_medidor` TEXT NOT NULL, `num_medidor` TEXT NOT NULL, FOREIGN KEY (`num_medidor`) REFERENCES `Medidor` (`num_medidor`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NuevaMedicion` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `cuenta` TEXT NOT NULL, `tipo` TEXT NOT NULL, `estado` TEXT NOT NULL, `fecha` TEXT NOT NULL, `lectura` INTEGER NOT NULL, `foto` BLOB NOT NULL, `nombreFoto` TEXT NOT NULL, `num_medidor` TEXT NOT NULL, `estado_envio` INTEGER NOT NULL, FOREIGN KEY (`num_medidor`) REFERENCES `Medidor` (`num_medidor`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Demanda` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `cuenta` TEXT NOT NULL, `lectura` REAL NOT NULL, `foto` BLOB NOT NULL, `nombreFoto` TEXT NOT NULL, `id_nueva_medicion` INTEGER NOT NULL, `estado_envio` INTEGER NOT NULL, FOREIGN KEY (`id_nueva_medicion`) REFERENCES `NuevaMedicion` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ClienteDao get clienteDao {
    return _clienteDaoInstance ??= _$ClienteDao(database, changeListener);
  }

  @override
  UsuarioDao get usuarioDao {
    return _usuarioDaoInstance ??= _$UsuarioDao(database, changeListener);
  }

  @override
  EstadoDao get estadoDao {
    return _estadoDaoInstance ??= _$EstadoDao(database, changeListener);
  }

  @override
  MedidorDao get medidorDao {
    return _medidorDaoInstance ??= _$MedidorDao(database, changeListener);
  }

  @override
  MedicionDao get medicionDao {
    return _medicionDaoInstance ??= _$MedicionDao(database, changeListener);
  }

  @override
  NuevaMedicionDao get nuevamedicionDao {
    return _nuevamedicionDaoInstance ??=
        _$NuevaMedicionDao(database, changeListener);
  }

  @override
  DemandaDao get demandaDao {
    return _demandaDaoInstance ??= _$DemandaDao(database, changeListener);
  }
}

class _$ClienteDao extends ClienteDao {
  _$ClienteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _clienteInsertionAdapter = InsertionAdapter(
            database,
            'Cliente',
            (Cliente item) => <String, Object?>{
                  'cuenta_id': item.cuenta_id,
                  'cedula': item.cedula,
                  'nombre': item.nombre,
                  'apellido': item.apellido,
                  'direccion': item.direccion,
                  'celular': item.celular,
                  'valor': item.valor,
                  'planillas': item.planillas
                }),
        _clienteUpdateAdapter = UpdateAdapter(
            database,
            'Cliente',
            ['cuenta_id'],
            (Cliente item) => <String, Object?>{
                  'cuenta_id': item.cuenta_id,
                  'cedula': item.cedula,
                  'nombre': item.nombre,
                  'apellido': item.apellido,
                  'direccion': item.direccion,
                  'celular': item.celular,
                  'valor': item.valor,
                  'planillas': item.planillas
                }),
        _clienteDeletionAdapter = DeletionAdapter(
            database,
            'Cliente',
            ['cuenta_id'],
            (Cliente item) => <String, Object?>{
                  'cuenta_id': item.cuenta_id,
                  'cedula': item.cedula,
                  'nombre': item.nombre,
                  'apellido': item.apellido,
                  'direccion': item.direccion,
                  'celular': item.celular,
                  'valor': item.valor,
                  'planillas': item.planillas
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Cliente> _clienteInsertionAdapter;

  final UpdateAdapter<Cliente> _clienteUpdateAdapter;

  final DeletionAdapter<Cliente> _clienteDeletionAdapter;

  @override
  Future<Cliente?> findClienteById(String cuenta) async {
    return _queryAdapter.query('SELECT * FROM Cliente c WHERE c.cuenta_id = ?1',
        mapper: (Map<String, Object?> row) => Cliente(
            cuenta_id: row['cuenta_id'] as String,
            cedula: row['cedula'] as String,
            nombre: row['nombre'] as String,
            apellido: row['apellido'] as String,
            direccion: row['direccion'] as String,
            celular: row['celular'] as String,
            valor: row['valor'] as double,
            planillas: row['planillas'] as int),
        arguments: [cuenta]);
  }

  @override
  Future<Cliente?> getClientebyNombre(String nombre) async {
    return _queryAdapter.query('SELECT * FROM Cliente WHERE nombre LIKE ?1',
        mapper: (Map<String, Object?> row) => Cliente(
            cuenta_id: row['cuenta_id'] as String,
            cedula: row['cedula'] as String,
            nombre: row['nombre'] as String,
            apellido: row['apellido'] as String,
            direccion: row['direccion'] as String,
            celular: row['celular'] as String,
            valor: row['valor'] as double,
            planillas: row['planillas'] as int),
        arguments: [nombre]);
  }

  @override
  Future<List<Cliente>> findAllClientes() async {
    return _queryAdapter.queryList('SELECT * FROM Cliente',
        mapper: (Map<String, Object?> row) => Cliente(
            cuenta_id: row['cuenta_id'] as String,
            cedula: row['cedula'] as String,
            nombre: row['nombre'] as String,
            apellido: row['apellido'] as String,
            direccion: row['direccion'] as String,
            celular: row['celular'] as String,
            valor: row['valor'] as double,
            planillas: row['planillas'] as int));
  }

  @override
  Future<void> insertCliente(Cliente cliente) async {
    await _clienteInsertionAdapter.insert(cliente, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertClientes(List<Cliente> clientes) async {
    await _clienteInsertionAdapter.insertList(
        clientes, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCliente(Cliente cliente) async {
    await _clienteUpdateAdapter.update(cliente, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCliente(Cliente cliente) async {
    await _clienteDeletionAdapter.delete(cliente);
  }
}

class _$UsuarioDao extends UsuarioDao {
  _$UsuarioDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _usuarioInsertionAdapter = InsertionAdapter(
            database,
            'Usuario',
            (Usuario item) => <String, Object?>{
                  'id': item.id,
                  'usuario': item.usuario,
                  'clave': item.clave
                },
            changeListener),
        _usuarioUpdateAdapter = UpdateAdapter(
            database,
            'Usuario',
            ['id'],
            (Usuario item) => <String, Object?>{
                  'id': item.id,
                  'usuario': item.usuario,
                  'clave': item.clave
                },
            changeListener),
        _usuarioDeletionAdapter = DeletionAdapter(
            database,
            'Usuario',
            ['id'],
            (Usuario item) => <String, Object?>{
                  'id': item.id,
                  'usuario': item.usuario,
                  'clave': item.clave
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Usuario> _usuarioInsertionAdapter;

  final UpdateAdapter<Usuario> _usuarioUpdateAdapter;

  final DeletionAdapter<Usuario> _usuarioDeletionAdapter;

  @override
  Stream<Usuario?> findUsuarioById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Usuario WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Usuario(
            id: row['id'] as int?,
            usuario: row['usuario'] as String,
            clave: row['clave'] as String),
        arguments: [id],
        queryableName: 'Usuario',
        isView: false);
  }

  @override
  Future<Usuario?> getUsuariobyNombre(String nombre) async {
    return _queryAdapter.query('SELECT * FROM Usuario WHERE nombre LIKE ?1',
        mapper: (Map<String, Object?> row) => Usuario(
            id: row['id'] as int?,
            usuario: row['usuario'] as String,
            clave: row['clave'] as String),
        arguments: [nombre]);
  }

  @override
  Future<List<Usuario>> findAllUsuarios() async {
    return _queryAdapter.queryList('SELECT *FROM Usuario',
        mapper: (Map<String, Object?> row) => Usuario(
            id: row['id'] as int?,
            usuario: row['usuario'] as String,
            clave: row['clave'] as String));
  }

  @override
  Future<void> insertUsuario(Usuario usuario) async {
    await _usuarioInsertionAdapter.insert(usuario, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertUsuarios(List<Usuario> usuarios) async {
    await _usuarioInsertionAdapter.insertList(
        usuarios, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateUsuario(Usuario usuario) async {
    await _usuarioUpdateAdapter.update(usuario, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUsuario(Usuario usuario) async {
    await _usuarioDeletionAdapter.delete(usuario);
  }
}

class _$EstadoDao extends EstadoDao {
  _$EstadoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _estadoInsertionAdapter = InsertionAdapter(
            database,
            'Estado',
            (Estado item) => <String, Object?>{
                  'codigo': item.codigo,
                  'descripcion': item.descripcion
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Estado> _estadoInsertionAdapter;

  @override
  Future<List<Estado>> findAllEstados() async {
    return _queryAdapter.queryList('SELECT *FROM Estado',
        mapper: (Map<String, Object?> row) => Estado(
            codigo: row['codigo'] as String,
            descripcion: row['descripcion'] as String));
  }

  @override
  Future<void> insertEstado(Estado estado) async {
    await _estadoInsertionAdapter.insert(estado, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertEstados(List<Estado> clientes) async {
    await _estadoInsertionAdapter.insertList(
        clientes, OnConflictStrategy.abort);
  }
}

class _$MedidorDao extends MedidorDao {
  _$MedidorDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _medidorInsertionAdapter = InsertionAdapter(
            database,
            'Medidor',
            (Medidor item) => <String, Object?>{
                  'num_medidor': item.num_medidor,
                  'esferas': item.esferas,
                  'coordenada_x': item.coordenada_x,
                  'coordenada_y': item.coordenada_y,
                  'secuencia': item.secuencia,
                  'ruta': item.ruta,
                  'sector': item.sector,
                  'zona': item.zona,
                  'bloque': item.bloque,
                  'demanda_facturable': item.demanda_facturable,
                  'cuenta_id': item.cuenta_id
                },
            changeListener),
        _medidorUpdateAdapter = UpdateAdapter(
            database,
            'Medidor',
            ['num_medidor'],
            (Medidor item) => <String, Object?>{
                  'num_medidor': item.num_medidor,
                  'esferas': item.esferas,
                  'coordenada_x': item.coordenada_x,
                  'coordenada_y': item.coordenada_y,
                  'secuencia': item.secuencia,
                  'ruta': item.ruta,
                  'sector': item.sector,
                  'zona': item.zona,
                  'bloque': item.bloque,
                  'demanda_facturable': item.demanda_facturable,
                  'cuenta_id': item.cuenta_id
                },
            changeListener),
        _medidorDeletionAdapter = DeletionAdapter(
            database,
            'Medidor',
            ['num_medidor'],
            (Medidor item) => <String, Object?>{
                  'num_medidor': item.num_medidor,
                  'esferas': item.esferas,
                  'coordenada_x': item.coordenada_x,
                  'coordenada_y': item.coordenada_y,
                  'secuencia': item.secuencia,
                  'ruta': item.ruta,
                  'sector': item.sector,
                  'zona': item.zona,
                  'bloque': item.bloque,
                  'demanda_facturable': item.demanda_facturable,
                  'cuenta_id': item.cuenta_id
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Medidor> _medidorInsertionAdapter;

  final UpdateAdapter<Medidor> _medidorUpdateAdapter;

  final DeletionAdapter<Medidor> _medidorDeletionAdapter;

  @override
  Stream<Medidor?> findMedidorByIdAll(String id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM Medidor m WHERE m.num_medidor = ?1',
        mapper: (Map<String, Object?> row) => Medidor(
            num_medidor: row['num_medidor'] as String,
            esferas: row['esferas'] as int,
            coordenada_x: row['coordenada_x'] as double,
            coordenada_y: row['coordenada_y'] as double,
            secuencia: row['secuencia'] as int,
            ruta: row['ruta'] as int,
            sector: row['sector'] as int,
            zona: row['zona'] as String?,
            bloque: row['bloque'] as int,
            demanda_facturable: row['demanda_facturable'] as double?,
            cuenta_id: row['cuenta_id'] as String),
        arguments: [id],
        queryableName: 'Medidor',
        isView: false);
  }

  @override
  Future<Medidor?> findMedidorById(String id) async {
    return _queryAdapter.query(
        'SELECT * FROM Medidor m WHERE m.num_medidor = ?1',
        mapper: (Map<String, Object?> row) => Medidor(
            num_medidor: row['num_medidor'] as String,
            esferas: row['esferas'] as int,
            coordenada_x: row['coordenada_x'] as double,
            coordenada_y: row['coordenada_y'] as double,
            secuencia: row['secuencia'] as int,
            ruta: row['ruta'] as int,
            sector: row['sector'] as int,
            zona: row['zona'] as String?,
            bloque: row['bloque'] as int,
            demanda_facturable: row['demanda_facturable'] as double?,
            cuenta_id: row['cuenta_id'] as String),
        arguments: [id]);
  }

  @override
  Future<List<Medidor>> findAllMedidores() async {
    return _queryAdapter.queryList('SELECT * FROM Medidor',
        mapper: (Map<String, Object?> row) => Medidor(
            num_medidor: row['num_medidor'] as String,
            esferas: row['esferas'] as int,
            coordenada_x: row['coordenada_x'] as double,
            coordenada_y: row['coordenada_y'] as double,
            secuencia: row['secuencia'] as int,
            ruta: row['ruta'] as int,
            sector: row['sector'] as int,
            zona: row['zona'] as String?,
            bloque: row['bloque'] as int,
            demanda_facturable: row['demanda_facturable'] as double?,
            cuenta_id: row['cuenta_id'] as String));
  }

  @override
  Future<List<Medidor>> findAllMedidoresByRutaSector(
      int ruta, int sector) async {
    return _queryAdapter.queryList(
        'select * from Medidor m where m.ruta= ?1 and m.sector= ?2 order by m.secuencia ASC',
        mapper: (Map<String, Object?> row) => Medidor(num_medidor: row['num_medidor'] as String, esferas: row['esferas'] as int, coordenada_x: row['coordenada_x'] as double, coordenada_y: row['coordenada_y'] as double, secuencia: row['secuencia'] as int, ruta: row['ruta'] as int, sector: row['sector'] as int, zona: row['zona'] as String?, bloque: row['bloque'] as int, demanda_facturable: row['demanda_facturable'] as double?, cuenta_id: row['cuenta_id'] as String),
        arguments: [ruta, sector]);
  }

  @override
  Future<List<Medidor>> findAllMedidoresNoLectura(
      int _sector, int _ruta) async {
    return _queryAdapter.queryList(
        'select m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id from Medidor m LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor where nm.id  is NULL and m.sector = ?1 and m.ruta = ?2 order by m.secuencia asc',
        mapper: (Map<String, Object?> row) => Medidor(num_medidor: row['num_medidor'] as String, esferas: row['esferas'] as int, coordenada_x: row['coordenada_x'] as double, coordenada_y: row['coordenada_y'] as double, secuencia: row['secuencia'] as int, ruta: row['ruta'] as int, sector: row['sector'] as int, zona: row['zona'] as String?, bloque: row['bloque'] as int, demanda_facturable: row['demanda_facturable'] as double?, cuenta_id: row['cuenta_id'] as String),
        arguments: [_sector, _ruta]);
  }

  @override
  Future<List<Medidor>> buscarTodoLeido(int _sector, int _ruta) async {
    return _queryAdapter.queryList(
        'select DISTINCT m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id from Medidor m LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor where nm.id  is not NULL and m.sector = ?1 and m.ruta = ?2 order by m.secuencia asc',
        mapper: (Map<String, Object?> row) => Medidor(num_medidor: row['num_medidor'] as String, esferas: row['esferas'] as int, coordenada_x: row['coordenada_x'] as double, coordenada_y: row['coordenada_y'] as double, secuencia: row['secuencia'] as int, ruta: row['ruta'] as int, sector: row['sector'] as int, zona: row['zona'] as String?, bloque: row['bloque'] as int, demanda_facturable: row['demanda_facturable'] as double?, cuenta_id: row['cuenta_id'] as String),
        arguments: [_sector, _ruta]);
  }

  @override
  Future<List<Medidor>> buscarTodoLNL(int _sector, int _ruta) async {
    return _queryAdapter.queryList(
        'select DISTINCT  m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id from Medidor m LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor where m.sector = ?1 and m.ruta = ?2 order by m.secuencia asc',
        mapper: (Map<String, Object?> row) => Medidor(num_medidor: row['num_medidor'] as String, esferas: row['esferas'] as int, coordenada_x: row['coordenada_x'] as double, coordenada_y: row['coordenada_y'] as double, secuencia: row['secuencia'] as int, ruta: row['ruta'] as int, sector: row['sector'] as int, zona: row['zona'] as String?, bloque: row['bloque'] as int, demanda_facturable: row['demanda_facturable'] as double?, cuenta_id: row['cuenta_id'] as String),
        arguments: [_sector, _ruta]);
  }

  @override
  Future<List<Medidor>> buscarNLCadena(
      int _sector, int _ruta, String _cuenta) async {
    return _queryAdapter.queryList(
        'select m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id from Medidor m LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor where nm.id  is NULL and  m.cuenta_id = ?3 and m.sector = ?1 and m.ruta = ?2 order by m.secuencia asc',
        mapper: (Map<String, Object?> row) => Medidor(num_medidor: row['num_medidor'] as String, esferas: row['esferas'] as int, coordenada_x: row['coordenada_x'] as double, coordenada_y: row['coordenada_y'] as double, secuencia: row['secuencia'] as int, ruta: row['ruta'] as int, sector: row['sector'] as int, zona: row['zona'] as String?, bloque: row['bloque'] as int, demanda_facturable: row['demanda_facturable'] as double?, cuenta_id: row['cuenta_id'] as String),
        arguments: [_sector, _ruta, _cuenta]);
  }

  @override
  Future<List<Medidor>> buscarLCadena(
      int _sector, int _ruta, String _cuenta) async {
    return _queryAdapter.queryList(
        'select DISTINCT m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id from Medidor m LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor where nm.id is not NULL and  m.cuenta_id = ?3 and m.sector = ?1 and m.ruta = ?2 order by m.secuencia asc',
        mapper: (Map<String, Object?> row) => Medidor(num_medidor: row['num_medidor'] as String, esferas: row['esferas'] as int, coordenada_x: row['coordenada_x'] as double, coordenada_y: row['coordenada_y'] as double, secuencia: row['secuencia'] as int, ruta: row['ruta'] as int, sector: row['sector'] as int, zona: row['zona'] as String?, bloque: row['bloque'] as int, demanda_facturable: row['demanda_facturable'] as double?, cuenta_id: row['cuenta_id'] as String),
        arguments: [_sector, _ruta, _cuenta]);
  }

  @override
  Future<List<Medidor>> buscarLNLCadena(
      int _sector, int _ruta, String _cuenta) async {
    return _queryAdapter.queryList(
        'select m.num_medidor, m.esferas, m.coordenada_x, m.coordenada_y, m.secuencia, m.ruta, m.sector, m.zona, m.bloque, m.demanda_facturable, m.cuenta_id from Medidor m LEFT  JOIN NuevaMedicion nm on m.num_medidor =nm.num_medidor where m.cuenta_id = ?3 and m.sector = ?1 and m.ruta = ?2 order by m.secuencia asc',
        mapper: (Map<String, Object?> row) => Medidor(num_medidor: row['num_medidor'] as String, esferas: row['esferas'] as int, coordenada_x: row['coordenada_x'] as double, coordenada_y: row['coordenada_y'] as double, secuencia: row['secuencia'] as int, ruta: row['ruta'] as int, sector: row['sector'] as int, zona: row['zona'] as String?, bloque: row['bloque'] as int, demanda_facturable: row['demanda_facturable'] as double?, cuenta_id: row['cuenta_id'] as String),
        arguments: [_sector, _ruta, _cuenta]);
  }

  @override
  Stream<List<dynamic>> findAllfindAllRutas() {
    return _queryAdapter.queryListStream(
        'select DISTINCT m.ruta,  m.sector  from Medidor m',
        mapper: (Map<String, dynamic> row) =>
            [row['ruta'] as int, row['sector'] as int],
        queryableName: 'Bills',
        isView: false);
  }

  @override
  Future<void> insertMedidor(Medidor medidor) async {
    await _medidorInsertionAdapter.insert(medidor, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMedidores(List<Medidor> medidores) async {
    await _medidorInsertionAdapter.insertList(
        medidores, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMedidor(Medidor medidor) async {
    await _medidorUpdateAdapter.update(medidor, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMedidor(Medidor medidor) async {
    await _medidorDeletionAdapter.delete(medidor);
  }
}

class _$MedicionDao extends MedicionDao {
  _$MedicionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _medicionInsertionAdapter = InsertionAdapter(
            database,
            'Medicion',
            (Medicion item) => <String, Object?>{
                  'id': item.id,
                  'lectura_anterior': item.lectura_anterior,
                  'consumo_promedio': item.consumo_promedio,
                  'tipo_medidor': item.tipo_medidor,
                  'num_medidor': item.num_medidor
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Medicion> _medicionInsertionAdapter;

  @override
  Future<List<Medicion>> findAllMediciones() async {
    return _queryAdapter.queryList('SELECT * FROM Medicion',
        mapper: (Map<String, Object?> row) => Medicion(
            id: row['id'] as int?,
            lectura_anterior: row['lectura_anterior'] as int,
            consumo_promedio: row['consumo_promedio'] as int,
            tipo_medidor: row['tipo_medidor'] as String,
            num_medidor: row['num_medidor'] as String));
  }

  @override
  Future<Medicion?> findByMedidorId(String id) async {
    return _queryAdapter.query(
        'SELECT * FROM Medicion m WHERE m.num_medidor = ?1',
        mapper: (Map<String, Object?> row) => Medicion(
            id: row['id'] as int?,
            lectura_anterior: row['lectura_anterior'] as int,
            consumo_promedio: row['consumo_promedio'] as int,
            tipo_medidor: row['tipo_medidor'] as String,
            num_medidor: row['num_medidor'] as String),
        arguments: [id]);
  }

  @override
  Future<List<Medicion>> findMedicionesOfMedidor(String id) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Medicion m WHERE m.num_medidor = ?1 ORDER BY m.tipo_medidor ASC',
        mapper: (Map<String, Object?> row) => Medicion(id: row['id'] as int?, lectura_anterior: row['lectura_anterior'] as int, consumo_promedio: row['consumo_promedio'] as int, tipo_medidor: row['tipo_medidor'] as String, num_medidor: row['num_medidor'] as String),
        arguments: [id]);
  }

  @override
  Future<Medicion?> findByMedicionId(String id) async {
    return _queryAdapter.query('SELECT * FROM Medicion m WHERE m.id = ?1',
        mapper: (Map<String, Object?> row) => Medicion(
            id: row['id'] as int?,
            lectura_anterior: row['lectura_anterior'] as int,
            consumo_promedio: row['consumo_promedio'] as int,
            tipo_medidor: row['tipo_medidor'] as String,
            num_medidor: row['num_medidor'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertMedicion(Medicion medicion) async {
    await _medicionInsertionAdapter.insert(medicion, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertMediciones(List<Medicion> mediciones) async {
    await _medicionInsertionAdapter.insertList(
        mediciones, OnConflictStrategy.abort);
  }
}

class _$NuevaMedicionDao extends NuevaMedicionDao {
  _$NuevaMedicionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _nuevaMedicionInsertionAdapter = InsertionAdapter(
            database,
            'NuevaMedicion',
            (NuevaMedicion item) => <String, Object?>{
                  'id': item.id,
                  'cuenta': item.cuenta,
                  'tipo': item.tipo,
                  'estado': item.estado,
                  'fecha': item.fecha,
                  'lectura': item.lectura,
                  'foto': item.foto,
                  'nombreFoto': item.nombreFoto,
                  'num_medidor': item.num_medidor,
                  'estado_envio': item.estado_envio ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NuevaMedicion> _nuevaMedicionInsertionAdapter;

  @override
  Future<List<NuevaMedicion>> findAllNuevaMedicion() async {
    return _queryAdapter.queryList('SELECT * FROM NuevaMedicion',
        mapper: (Map<String, Object?> row) => NuevaMedicion(
            id: row['id'] as int?,
            cuenta: row['cuenta'] as String,
            tipo: row['tipo'] as String,
            estado: row['estado'] as String,
            fecha: row['fecha'] as String,
            lectura: row['lectura'] as int,
            nombreFoto: row['nombreFoto'] as String,
            foto: row['foto'] as Uint8List,
            num_medidor: row['num_medidor'] as String,
            estado_envio: (row['estado_envio'] as int) != 0));
  }

  @override
  Future<List<NuevaMedicion>> findMedicionesOfMedidor(
      String num_medidor) async {
    return _queryAdapter.queryList(
        'select * from NuevaMedicion nm where num_medidor = ?1',
        mapper: (Map<String, Object?> row) => NuevaMedicion(
            id: row['id'] as int?,
            cuenta: row['cuenta'] as String,
            tipo: row['tipo'] as String,
            estado: row['estado'] as String,
            fecha: row['fecha'] as String,
            lectura: row['lectura'] as int,
            nombreFoto: row['nombreFoto'] as String,
            foto: row['foto'] as Uint8List,
            num_medidor: row['num_medidor'] as String,
            estado_envio: (row['estado_envio'] as int) != 0),
        arguments: [num_medidor]);
  }

  @override
  Future<List<NuevaMedicion>> buscarMedicionesNoEnviadas() async {
    return _queryAdapter.queryList(
        'select * from NuevaMedicion nm where estado_envio = false',
        mapper: (Map<String, Object?> row) => NuevaMedicion(
            id: row['id'] as int?,
            cuenta: row['cuenta'] as String,
            tipo: row['tipo'] as String,
            estado: row['estado'] as String,
            fecha: row['fecha'] as String,
            lectura: row['lectura'] as int,
            nombreFoto: row['nombreFoto'] as String,
            foto: row['foto'] as Uint8List,
            num_medidor: row['num_medidor'] as String,
            estado_envio: (row['estado_envio'] as int) != 0));
  }

  @override
  Future<void> actualizarEstadoEnvio(bool nuevo_estado, int id) async {
    await _queryAdapter.queryNoReturn(
        'update NuevaMedicion set estado_envio = ?1 where id = ?2',
        arguments: [nuevo_estado ? 1 : 0, id]);
  }

  @override
  Future<void> eliminarMedicionesPorNumMedidor(String num_med) async {
    await _queryAdapter.queryNoReturn(
        'delete from NuevaMedicion where num_medidor = ?1',
        arguments: [num_med]);
  }

  @override
  Future<int> insertNuevaMedicion(NuevaMedicion nuevamedicion) {
    return _nuevaMedicionInsertionAdapter.insertAndReturnId(
        nuevamedicion, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertNuevaMediciones(
      List<NuevaMedicion> nuevasmediciones) {
    return _nuevaMedicionInsertionAdapter.insertListAndReturnIds(
        nuevasmediciones, OnConflictStrategy.abort);
  }
}

class _$DemandaDao extends DemandaDao {
  _$DemandaDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _demandaInsertionAdapter = InsertionAdapter(
            database,
            'Demanda',
            (Demanda item) => <String, Object?>{
                  'id': item.id,
                  'cuenta': item.cuenta,
                  'lectura': item.lectura,
                  'foto': item.foto,
                  'nombreFoto': item.nombreFoto,
                  'id_nueva_medicion': item.id_nueva_medicion,
                  'estado_envio': item.estado_envio ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Demanda> _demandaInsertionAdapter;

  @override
  Future<List<Demanda>> findAllDemandas() async {
    return _queryAdapter.queryList('SELECT * FROM Demanda',
        mapper: (Map<String, Object?> row) => Demanda(
            id: row['id'] as int?,
            cuenta: row['cuenta'] as String,
            lectura: row['lectura'] as double,
            nombreFoto: row['nombreFoto'] as String,
            foto: row['foto'] as Uint8List,
            id_nueva_medicion: row['id_nueva_medicion'] as int,
            estado_envio: (row['estado_envio'] as int) != 0));
  }

  @override
  Future<Demanda?> findByDemandaId(String id) async {
    return _queryAdapter.query('SELECT * FROM Demanda d WHERE d.id = ?1',
        mapper: (Map<String, Object?> row) => Demanda(
            id: row['id'] as int?,
            cuenta: row['cuenta'] as String,
            lectura: row['lectura'] as double,
            nombreFoto: row['nombreFoto'] as String,
            foto: row['foto'] as Uint8List,
            id_nueva_medicion: row['id_nueva_medicion'] as int,
            estado_envio: (row['estado_envio'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<Demanda?> findByMedicionId(int id_medicion) async {
    return _queryAdapter.query(
        'SELECT * FROM Demanda d WHERE d.id_nueva_medicion = ?1',
        mapper: (Map<String, Object?> row) => Demanda(
            id: row['id'] as int?,
            cuenta: row['cuenta'] as String,
            lectura: row['lectura'] as double,
            nombreFoto: row['nombreFoto'] as String,
            foto: row['foto'] as Uint8List,
            id_nueva_medicion: row['id_nueva_medicion'] as int,
            estado_envio: (row['estado_envio'] as int) != 0),
        arguments: [id_medicion]);
  }

  @override
  Future<List<Demanda>> buscarMedicionesNoEnviadas() async {
    return _queryAdapter.queryList(
        'select * from Demanda d where estado_envio = false',
        mapper: (Map<String, Object?> row) => Demanda(
            id: row['id'] as int?,
            cuenta: row['cuenta'] as String,
            lectura: row['lectura'] as double,
            nombreFoto: row['nombreFoto'] as String,
            foto: row['foto'] as Uint8List,
            id_nueva_medicion: row['id_nueva_medicion'] as int,
            estado_envio: (row['estado_envio'] as int) != 0));
  }

  @override
  Future<void> actualizarEstadoEnvio(bool nuevo_estado, int id) async {
    await _queryAdapter.queryNoReturn(
        'update Demanda set estado_envio = ?1 where id = ?2',
        arguments: [nuevo_estado ? 1 : 0, id]);
  }

  @override
  Future<void> insertDemanda(Demanda demanda) async {
    await _demandaInsertionAdapter.insert(demanda, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertDemandas(List<Demanda> demandas) async {
    await _demandaInsertionAdapter.insertList(
        demandas, OnConflictStrategy.abort);
  }
}
