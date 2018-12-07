import 'package:cakes_catalog/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<FirebaseUser> _signIn() async {
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);
    print('User Name: ${user.displayName}');
    return user;
  }

  void _signOut() {
    googleSignIn.signOut();
    print('User sign out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
        centerTitle: true,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Center(
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Image.asset(
                'assets/cafe.png',
                height: 160.0,
              ),
                  )),
              RaisedButton(
                onPressed: () {
                  _signIn().then((FirebaseUser user) {
                    print(user);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => HomePage()));
                  }).catchError((e) => print(e));
                },
                child: Text('Sign in'),
                color: Colors.green,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
              ),
              RaisedButton(
                onPressed: _signOut,
                child: Text('Sign out'),
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
