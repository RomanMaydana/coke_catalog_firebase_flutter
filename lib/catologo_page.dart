import 'package:cakes_catalog/cake.dart';
import 'package:cakes_catalog/list_item.dart';
import 'package:cakes_catalog/pedidos_list.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatalogoPage extends StatefulWidget {
  @override
  _CatalogoPageState createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Productos Disponibles',style: TextStyle(color: Colors.black),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context){
                  return PedidosList();
                }
              ));
            },
          )
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('cakes').snapshots(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          return _buildList(context, snapshot.data.documents);
        }
        else{
          return LinearProgressIndicator();
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        padding: EdgeInsets.only(top: 20.0),
        children: snapshot.map((data) => _buildListItem(context, data)).toList());
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final cake = Cake.fromSnapshot(data);
    return ListItem(nombre: cake.nombre,imagen: cake.imagen, origen: cake.origen,precio: cake.precio,reference: cake.reference,);
  }
}
