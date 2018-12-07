import 'package:cloud_firestore/cloud_firestore.dart';

class Compra {
  final String producto;
  final String cantidad;
  final String fecha;
  final DocumentReference reference;

  Compra.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['producto'] != null),
        assert(map['cantidad'] != null),
        assert(map['fecha'] != null),
        producto = map['producto'],
        cantidad = map['cantidad'],
        fecha = map['fecha'];

  Compra.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
