import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sociocon/core/models/post_model.dart';

class BuildImage extends StatelessWidget {
  final String imageUrl;
  final PostModel post;

  BuildImage({
    required this.post,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      key: UniqueKey(),
      fit: post.imageType == false || post.mediaUrls.length > 1
          ? BoxFit.fill
          : post.type == 2 && post.imageType && post.mediaUrls.length == 1
              ? BoxFit.fitWidth
              : post.type == 1 && post.imageType && post.mediaUrls.length == 1
                  ? BoxFit.cover
                  : BoxFit.fill,
    );
  }
}
