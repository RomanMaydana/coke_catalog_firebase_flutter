import 'package:cakes_catalog/my_home_page.dart';
import 'package:flutter/material.dart';

// 1. importar 'dart:async'
import 'dart:async';

//2. crear una clase StatefulWidget de nombre SplashScreem
class SplashScreem extends StatefulWidget {
  @override
  _SplashScreemState createState() => _SplashScreemState();
}

// 3. Creando el estado de SplashScreem
class _SplashScreemState extends State<SplashScreem> {
  // 4. crear la siguiente variable
  Timer _timer;

  // 5. la función initState() la tenemos gracias a que
  // esta clase es StatefulWidget
  @override
  void initState() {
    // 6. temporizador por 2 segundos, pasado los 2 seg llamará
    // a la función _onShowLogin
    _timer = Timer(const Duration(seconds: 2), _onShowLogin);
    super.initState();
  }

  _onShowLogin() {
    if (mounted) {
      // Pasará a la siguiente pantalla (contedido de login_page.dart)
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        return MyHomePage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Splash Screem'),
      ),
      backgroundColor: Colors.red,
      // el contendido de la primera pantalla
      body: Center(
        child: Icon(Icons.local_pizza,size: 200.0,),
      ),
    );
  }
}
