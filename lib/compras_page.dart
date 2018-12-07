import 'package:cakes_catalog/compra.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComprasPage extends StatefulWidget {
  @override
  _ComprasPageState createState() => _ComprasPageState();
}

class _ComprasPageState extends State<ComprasPage> {
  final CollectionReference collectionReference =
      Firestore.instance.collection('compras');
  final _formKey = GlobalKey<FormState>();
  String _producto = '';
  String _cantidad = '';
  String _date = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pasteles Disponibles',
        ),

        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _onTap(context);
        },
      ),
      body: _buildBody(context),
    );
  }

  _onTap(BuildContext context) {
    final alert = AlertDialog(
      title: Text('Compras'),
      content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    labelText: 'PRODUCTO',
                    labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                validator: (value) => value.isEmpty ? 'Ingrese producto' : null,
                onSaved: (value) => _producto = value,
              ),
              TextFormField(
                maxLength: 3,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'CANTIDAD',
                    labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                validator: (value) => value.isEmpty ? 'Ingrese cantidad' : null,
                onSaved: (value) => _cantidad = value,
              ),
            ],
          )),
      actions: <Widget>[
        FlatButton(
          child: Text('Fecha'),
          onPressed: _select,
        ),
        FlatButton(
            onPressed: _confirmar,
            child: Text(
              'OK',
            )),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('CANCEL',style: TextStyle(color: Colors.white),),
          color: Colors.red,
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }

  Future _select() async {
    DateTime picker = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2017),
        lastDate: DateTime(2020));
    if (picker != null) {
      setState(() {
        _date = picker.toString();
      });
    } else {
      setState(() {
        _date = DateTime.now().toString();
      });
    }
  }

  void _confirmar() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print('en $_producto y cant $_cantidad');
      Map<String, String> data = <String, String>{
        "producto": "${_producto}",
        "cantidad": "$_cantidad",
        "fecha": "$_date",
      };
      collectionReference.add(data).whenComplete(() {
        print('Add');
      }).catchError((e) => print(e));
      Navigator.pop(context);
    }
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('compras').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final compra = Compra.fromSnapshot(data);

    return Padding(
      key: ValueKey(compra.producto),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text(compra.producto),
          trailing: Text('Cantidad: ${compra.cantidad}'),
        ),
      ),
    );
  }
}
