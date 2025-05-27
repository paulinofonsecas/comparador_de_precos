import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DefaultImageWidget extends StatelessWidget {
  const DefaultImageWidget({
    required this.imageUrl,
    super.key,
    this.height = 256,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.width,
  });

  final String? imageUrl;
  final double height;
  final double? width;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Container(
        height: height,
        width: width,
        color: Colors.grey,
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      height: height,
      width: width,
      fit: fit,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: borderRadius,
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: borderRadius,
          ),
          child: const Center(
            child: Icon(Icons.error, color: Colors.red),
          ),
        );
      },
    );
  }
}
