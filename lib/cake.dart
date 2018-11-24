import 'package:cloud_firestore/cloud_firestore.dart';

class Cake {
  final String nombre;
  final String imagen;
  final String origen;
  final String precio;
  final DocumentReference reference;

  Cake.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nombre'] != null),
        assert(map['imagen'] != null),
        assert(map['origen'] != null),
        nombre = map['nombre'],
        imagen = map['imagen'],
        origen = map['origen'],
        precio = map['precio'];

  Cake.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}
