import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';

class NetworkCachedImage extends StatelessWidget {
  const NetworkCachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      progressIndicatorBuilder: (_, __, ___) {
        return const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircularProgressIndicator(
            color: AppColor.themeColor,
          ),
        );
      },
      errorWidget: (_,__,___){
        return const Icon(Icons.error_outline);
      },
    );
  }
}
