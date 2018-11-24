import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListItem extends StatefulWidget {
  final String nombre;
  final String imagen;
  final String origen;
  final String precio;
  final DocumentReference reference;

  ListItem(
      {this.nombre, this.imagen, this.origen, this.precio, this.reference});

  @override
  ListItemState createState() {
    return new ListItemState();
  }
}

class ListItemState extends State<ListItem> {
  final _formKey = GlobalKey<FormState>();
  String _mesa = '';
  String _cantidad = '';
  final CollectionReference collectionReference =
      Firestore.instance.collection('pedidos');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.0, left: 16.0),
      child: InkWell(
        splashColor: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          _onTap(context);
        },
        child: Container(
          height: 400.0,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  style: BorderStyle.solid,
                  width: 1.0),
              borderRadius: BorderRadius.circular(10.0)),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 125.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                        image: DecorationImage(
                            image: NetworkImage(widget.imagen),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, top: 5.0),
                    child: Text(
                      widget.nombre,
                      style: TextStyle(fontFamily: 'Quicksand', fontSize: 15.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.origen,
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 12.0,
                              color: Colors.grey),
                        ),
                        Text(
                          'USD ${widget.precio}',
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 12.0,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onTap(BuildContext context) {
    final alert = AlertDialog(
      title: Text('Datos'),
      content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                maxLength: 1,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'CANTIDAD',
                    labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                validator: (value) => value.isEmpty ? 'Ingrese cantidad' : null,
                onSaved: (value) => _cantidad = value,
              ),
              TextFormField(
                maxLength: 2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'MESA',
                    labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                validator: (value) => value.isEmpty ? 'Ingrese mesa' : null,
                onSaved: (value) => _mesa = value,
              ),
            ],
          )),
      actions: <Widget>[
        FlatButton(onPressed: _confirmar, child: Text('OK')),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL'),
          color: Colors.red,
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }

  void _confirmar() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print('en $_mesa y cant $_cantidad');

      Map<String, String> data = <String, String>{
        "nombre": "${widget.nombre}",
        "cantidad": "$_cantidad",
        "mesa": "$_mesa"
      };
      collectionReference
          .add(data)
          .whenComplete(() {
        print('Add');
      }).catchError((e)=>print(e));
      Navigator.pop(context);
    }
  }
}
