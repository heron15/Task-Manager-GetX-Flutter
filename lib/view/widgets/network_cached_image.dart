import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/asset_paths.dart';

class NetworkCachedImage extends StatelessWidget {
  const NetworkCachedImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.fit,
    this.errorIconRadius,
  });

  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double? errorIconRadius;

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
      errorWidget: (_, __, ___) {
        return CircleAvatar(
          radius: errorIconRadius,
          backgroundImage: const AssetImage(AssetPaths.profilePicture),
        );
      },
    );
  }
}
