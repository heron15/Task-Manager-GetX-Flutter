import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_color.dart';
import 'package:task_manager/utils/asset_paths.dart';

class CustomCircleAvatar extends StatefulWidget {
  const CustomCircleAvatar({
    super.key,
    required this.imageString,
    this.imageWidth,
    this.imageHeight,
    this.imageRadius,
    required this.borderColor,
  });

  final String imageString;
  final double? imageWidth;
  final double? imageHeight;
  final double? imageRadius;
  final Color borderColor;

  @override
  State<CustomCircleAvatar> createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  Uint8List? imageBytes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    setState(() {
      isLoading = true;
    });
    try {
      final bytes = base64Decode(widget.imageString);
      setState(() {
        imageBytes = bytes;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void didUpdateWidget(covariant CustomCircleAvatar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.imageString != oldWidget.imageString) {
      _loadImage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: const AssetImage(AssetPaths.profilePicture),
      radius: widget.imageRadius,
      child: isLoading
          ? const CircularProgressIndicator(
              color: AppColor.themeColor,
            )
          : Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  width: 2,
                  color: widget.borderColor,
                ),
                image: DecorationImage(
                  image: MemoryImage(imageBytes!),
                  fit: BoxFit.cover,
                  onError: (_, __) {
                    const AssetImage(AssetPaths.errorPicture);
                  },
                ),
              ),
            ),
    );
  }
}
