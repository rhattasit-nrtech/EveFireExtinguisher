import 'package:cached_network_image/cached_network_image.dart';
import 'package:evefireextin/widgets/show_progress.dart';
import 'package:flutter/material.dart';

class ShowNetworkImage extends StatelessWidget {
  final String urlImage;
  const ShowNetworkImage({Key? key, required this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlImage,
      placeholder: (context, url) => const ShowProgress(),
      errorWidget: (context, url, error) => Image.asset('images/question.png'),
    );
  }
}
