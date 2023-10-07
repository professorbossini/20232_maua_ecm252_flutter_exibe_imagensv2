import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/image_model.dart';
import 'widgets/image_list.dart';

class App extends StatefulWidget {
  @override
  State<App> createState() {
    return AppState();
  }
}

class AppState extends State<App> {
  int paginaAtual = 1;
  List<ImageModel> imagens = [];

  void obterImagem() async {
    var url = Uri.https(
      'api.pexels.com',
      '/v1/search',
      {'query': 'people', 'page': '$paginaAtual', 'per_page': '1'},
    );
    var req = http.Request('get', url);
    req.headers.addAll(
      {
        'Authorization': '563492ad6f91700001000001e00b21ab6afb45a18c1d44a759556f14',
      },
    );
    final result = await req.send();
    if (result.statusCode == 200) {
      final response = await http.Response.fromStream(result);
      var decodedJSON = json.decode(response.body);
      var imagem = ImageModel.fromJSON(decodedJSON);
      setState(() {
        paginaAtual++;
        imagens.add(imagem);
      });
    } else {
      print('Falhou');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Imagens"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: obterImagem,
      ),
      body: ImageList(imagens),
    ));
  }
}
