import 'package:cloud_firestore/cloud_firestore.dart';

class Pedido {
  final String nombre;
  final String cantidad;
  final String nombreCliente;
  final DocumentReference reference;

  Pedido.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nombre'] != null),
        assert(map['cantidad'] != null),
        assert(map['nombreCliente'] != null),
        nombre = map['nombre'],
        cantidad = map['cantidad'],
        nombreCliente = map['nombreCliente'];

  Pedido.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
