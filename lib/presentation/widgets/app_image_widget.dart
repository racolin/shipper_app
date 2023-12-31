import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shipper_app/presentation/res/strings/values.dart';

class AppImageWidget extends StatelessWidget {
  final String? image;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final String? cachedKey;
  final String assetsDefaultImage;
  final BoxFit fit;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const AppImageWidget({
    Key? key,
    required this.image,
    this.imageBuilder,
    this.errorWidget,
    this.cachedKey,
    this.assetsDefaultImage = assetDefaultImage,
    this.height = double.maxFinite,
    this.fit = BoxFit.cover,
    this.width = double.maxFinite,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var img = image == null ? null : image!.contains('http') ? image : 'http://$image';
    img = img?.replaceAll('localhost', '192.168.2.8');
    img = img?.replaceAll('127.0.0.1', '192.168.2.8');
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: img == null ? Image.asset(
        assetsDefaultImage,
        height: height,
        width: width,
        fit: BoxFit.cover,
      ) : CachedNetworkImage(
        cacheKey: cachedKey,
        imageUrl: img ?? '',
        imageBuilder: imageBuilder,
        height: height,
        width: width,
        fit: fit,
        errorWidget: errorWidget ?? (context, url, error) => Image.asset(
          assetsDefaultImage,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
        placeholder: (context, url) => Image.asset(
          assetsDefaultImage,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
