import 'package:floor/floor.dart';
import '../entity/cliente.dart';

@dao
abstract class ClienteDao {
  @insert
  Future<void> insertCliente(Cliente cliente);

  @insert
  Future<void> insertClientes(List<Cliente> clientes);

  @Query('SELECT * FROM Cliente c WHERE c.cuenta_id = :cuenta')
  Future<Cliente?> findClienteById(String cuenta);

  @Query('SELECT * FROM Cliente WHERE nombre LIKE :nombre')
  Future<Cliente?> getClientebyNombre(String nombre);

  @Query('SELECT * FROM Cliente')
  Future<List<Cliente>> findAllClientes();

  @update
  Future<void> updateCliente(Cliente cliente);

  @delete
  Future<void> deleteCliente(Cliente cliente);
}
