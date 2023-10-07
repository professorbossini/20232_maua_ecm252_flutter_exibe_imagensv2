import 'package:flutter/material.dart';
import '../models/image_model.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> imagens;

  ImageList(this.imagens);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: imagens.length,
      itemBuilder: (context, index){
        return Image.network(imagens[index].url);
      }
    );
  }
}
