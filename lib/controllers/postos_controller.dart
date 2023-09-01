import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class PostoController extends ChangeNotifier {
  double lat = 0.0;
  double long = 0.0;
  String erro = '';

  PostoController(){
    getPosicao();
  }

  getPosicao() async {
    try {
      Position posicao = await _posicaoAtual();
      lat = posicao.latitude;
      long = posicao.longitude;
    } catch (e) {
      erro = e.toString();
    }
    notifyListeners();
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool servicoAtivo = await Geolocator.isLocationServiceEnabled();

    //CASO 1: VERIFICAR SE O GPS ESTÁ ATIVADO
    if (!servicoAtivo) {
      return Future.error('Por favor, habilite a localização no smarphone');
    }

    //CASO 2: VERIFICAR HÁ PERMISSÃO DE ACESSO À LOCALIZAÇÃO
    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
      if (permissao != LocationPermission.whileInUse) {
        return Future.error('Você precisa autolizar o acesso à localização');
      }
    }

    //CASO 3: VERIFICAR SE A PERMISSÃO FOI REPROVADA PARA SEMPRE
    if (permissao == LocationPermission.deniedForever) {
      //Nesse caso, o usuário não poderá usar a localização e deverá dar a permissão manualmente
      return Future.error('Você precisa autolizar o acesso à localização');
    }

    return await Geolocator.getCurrentPosition();
  }
}
