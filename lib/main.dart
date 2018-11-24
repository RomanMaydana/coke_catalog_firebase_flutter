
import 'package:cakes_catalog/my_home_page.dart';
import 'package:flutter/material.dart';
import 'package:cakes_catalog/pedidos_list.dart';
void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.cyan
    ),
    home: PedidosList(),
  ));
}
