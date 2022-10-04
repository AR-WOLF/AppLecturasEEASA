import 'package:floor/floor.dart';
import '../entity/usuario.dart';

@dao
abstract class UsuarioDao {
  @insert
  Future<void> insertUsuario(Usuario usuario);

  @insert
  Future<void> insertUsuarios(List<Usuario> usuarios);

  @Query('SELECT * FROM Usuario WHERE id = :id')
  Stream<Usuario?> findUsuarioById(int id);

  @Query('SELECT * FROM Usuario WHERE nombre LIKE :nombre')
  Future<Usuario?> getUsuariobyNombre(String nombre);

  @Query('SELECT *FROM Usuario')
  Future<List<Usuario>> findAllUsuarios();

  @update
  Future<void> updateUsuario(Usuario usuario);

  @delete
  Future<void> deleteUsuario(Usuario usuario);
}
