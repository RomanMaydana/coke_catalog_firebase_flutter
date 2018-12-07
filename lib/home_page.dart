import 'package:cakes_catalog/catologo_page.dart';
import 'package:cakes_catalog/compras_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Opciones'),
        centerTitle: true,
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
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CatalogoPage()));
                    },
                    child: Center(
                        child: Text(
                      'Catálogo',
                      style: TextStyle(fontSize: 25.0),
                    )),
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
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ComprasPage()));
                  },
                  child: Center(
                      child: Text(
                    'Compras',
                    style: TextStyle(fontSize: 25.0),
                  )),
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
