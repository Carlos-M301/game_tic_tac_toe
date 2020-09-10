import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tres en línea',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: juegoGato(),
    );
  }
}

class juegoGato extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return _juegoGatoState();
  }
}

class _juegoGatoState extends State<juegoGato> {
  List<List> _matriz;
  _juegoGatoState(){
    _iniciarMatriz();
  }
  _iniciarMatriz(){
    _matriz = List<List>(3);//Longitud de la lista
    for(int i = 0; i < _matriz.length; i++){
      _matriz[i] = List(3);
      for(int j=0; j < _matriz[i].length; j++){
        _matriz[i][j] = ' ';
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Tres en línea'
        ),
      ),
      body:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildContenedorTablero(0,0),
                _buildContenedorTablero(0,1),
                _buildContenedorTablero(0,2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildContenedorTablero(1,0),
                _buildContenedorTablero(1,1),
                _buildContenedorTablero(1,2),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildContenedorTablero(2,0),
                _buildContenedorTablero(2,1),
                _buildContenedorTablero(2,2),
              ],
            ),
          ],
        ),
      ),
    );
  }
  String _ultimoCaracter = 'o';
  _buildContenedorTablero(int cordX, int cordY){
    return GestureDetector(
      onTap: (){
        _rellenarTablero(cordX,cordY);
        if(_revisarGanador(cordX,cordY)){
          _mostrarVentana(_matriz[cordX][cordY]);

        }
        else{
          if(_revisarDibujo()){
            _mostrarVentana(null);
          }
        }

      },
      child: Container(
        width: 90,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(
                color: Colors.black12
            )
        ),
        child:Center(
          child :Text(
            _matriz[cordX][cordY],
            style: TextStyle(
              fontSize: 92,

            ),
          ),
        ),
      ),
    );

  }
  _mostrarVentana(String ganador) {
    String texto;
    if (ganador == null){
      texto = 'Es un empate';
    }
    else{
      texto = 'Jugador $ganador ganó';
    }
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Fin del juego'),
            content: Text(texto),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  setState(() {
                    _iniciarMatriz();
                  });
                },
                child: Text('Nueva partida'),
              )
            ],
          );

        }
    );
  }
  _rellenarTablero(int cordX, int cordY){
    setState(() {
      if(_matriz[cordX][cordY] == ' '){
        if(_ultimoCaracter == 'o'){
          _matriz[cordX][cordY] = 'x';
        }
        else{
          _matriz[cordX][cordY] = 'o';
        }
        _ultimoCaracter = _matriz[cordX][cordY];
      }
    });
  }
  _revisarDibujo(){
    bool dibujo = true;
    _matriz.forEach((i){
      i.forEach((j) {
        if(j == ' ')
          dibujo = false;
      });
    });
    return dibujo;
  }

  _revisarGanador(int cordX, int cordY){
    int col = 0, renglon = 0, diag = 0, rdiag = 0;
    int n = _matriz.length-1;
    String jugador = _matriz[cordX][cordY];

    for(int i = 0; i < _matriz.length; i++){
      if(_matriz[cordX][i] == jugador)
        col++;
      if(_matriz[i][cordY] == jugador)
        renglon++;
      if(_matriz[i][i] == jugador)
        diag++;
      if(_matriz[i][n-1] == jugador)
        rdiag++;
    }
    if(renglon ==n+1 || col==n+1|| diag==n+1|| rdiag==n+1 ) {
      return true;
    }
    return false;

  }
}

