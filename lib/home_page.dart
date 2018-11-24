import 'package:cakes_catalog/compra_page.dart';
import 'package:cakes_catalog/pedidos_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: Container(
              height: 200.0,
              width: 200.0,
              child: Card(
                elevation: 3.0,
                child: Material(
                  color: Colors.red[200],
                  child: InkWell(
                    splashColor: Colors.red,
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CompraPage()));
                    },
                    child:Center(child: Text('Comprar',style: TextStyle(fontSize: 25.0),)),
                    ),
                  ),
                ),
            ),
          ),
          Container(
            height: 200.0,
            width: 200.0,
            child: Card(
              elevation: 3.0,
              child: Material(
                color: Colors.green[200],
                child: InkWell(
                  splashColor: Colors.green,
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PedidosList()));
                  },
                  child:Center(child: Text('Pedidos',style: TextStyle(fontSize: 25.0),)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
