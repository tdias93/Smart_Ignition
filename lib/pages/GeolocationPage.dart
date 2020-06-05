import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationPage extends StatefulWidget {
  @override
  _GeolocationPageState createState() => _GeolocationPageState();
}

class _GeolocationPageState extends State<GeolocationPage> {

  Completer<GoogleMapController> _controller = Completer();        // Completer -> Verifica se o comando foi executado, e salva o retorno
  CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(-20.1969659,-40.2340712),
      zoom: 17,                                     // Define Zoom
      tilt: 0,                                      // Define Angulo
      bearing: 0                                    // Define Rotação
  );

  Set<Marker> _marcadores = {};

  _onMapCreated(GoogleMapController mapController){

    _controller.complete(mapController);                          // Pega o retorno da criação do mapa

  }

  _movimentarCamera() async {

    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(
        CameraUpdate.newCameraPosition(_cameraPosition)            // Volta localização do mapa para o usuario
    );
  }


  _localizacaoAtual() async {

    Position position = await Geolocator().getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high                       // Define Precisão do GPS
    );

    setState(() {
      _cameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 17
      );
      _movimentarCamera();
    });

  }

  _adicionarListenerLocalizacao(){

    var geolocator = Geolocator();
    var locationOptions = LocationOptions(
        accuracy: LocationAccuracy.high,                      // Define Precisão do GPS
        distanceFilter: 10                                    // Distancia p/ Atualização
    );
    geolocator.getPositionStream( locationOptions )           // Passa Paramentro p/ Captura da Posição
        .listen((Position position){                          // Recebe Posição

      setState(() {
        _cameraPosition = CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 17
        );
        _movimentarCamera();
      });
    });
  }

  _marcador(LatLng latLng) async {
    List<Placemark> listaEnderecos = await Geolocator()
        .placemarkFromCoordinates(latLng.latitude,
        latLng.longitude); // Gera uma Lista com o Endereço do Marcador

    if (listaEnderecos != null && listaEnderecos.length > 0) {
      Placemark endereco = listaEnderecos[0]; // Pega Primeiro Valor da Lista

      String endPoint = endereco.thoroughfare + ', ' + endereco.subThoroughfare + ' - ' + endereco.subAdministrativeArea +'\\'+endereco.administrativeArea; // Pega Nome da Rua

      Marker marcador = Marker(
        markerId: MarkerId("marcador-${latLng.latitude}-${latLng.longitude}"),
        position: latLng,
        infoWindow: InfoWindow(
          title: endPoint,
        ),
        onTap: () {
          print(latLng);
          String coordinate = latLng.toString();
        },
      );

      setState(() {
        _marcadores.add(marcador);
      });
    }
  }

  @override
  void initState(){
    super.initState();
    //_recuperarLocalizacaoAtual();
    _adicionarListenerLocalizacao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 100,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 20),
                width: 90,
                height: 90,
                child: Image.asset('assent/Rota_1.png'),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: _movimentarCamera,
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 0),
        color: Colors.black12,
        child: GoogleMap(
          onMapCreated: _onMapCreated,               // Cria Mapa
          mapType: MapType.normal,                   // Tipo de Mapa
          initialCameraPosition: _cameraPosition,    // Posição Mapa
          markers: _marcadores,                      // Marcadores do Mapa
          onLongPress: _marcador,
          mapToolbarEnabled: true,                   // Habilita / Desabilita -> Ferramentas
          zoomControlsEnabled: false,                // Habilita / Desabilita -> Zoom
          myLocationButtonEnabled: false,            // Habilita / Desabilita -> Botão Minha Localizão
          myLocationEnabled: true,                   // Habilita / Desabilita -> Ponto de Localização
        ),
      ),
    );
  }
}
