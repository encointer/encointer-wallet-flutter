import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';

/// Displays an image from IPFS (folder + filename or direct CID).
/// Supports caching, loading placeholder, and error fallback.
class IpfsImage extends StatelessWidget {
  const IpfsImage({
    super.key,
    required this.ipfs,
    required this.cidOrFolder,
    this.fileName,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.borderRadius,
    this.placeholder,
    this.loadingBuilder,
    this.errorBuilder,
  });

  final IpfsApi ipfs;
  final String cidOrFolder;
  final String? fileName;
  final BoxFit fit;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  /// Default placeholder if loading
  final Widget? placeholder;

  /// Custom builder while loading (overrides placeholder)
  final Widget Function(BuildContext context)? loadingBuilder;

  /// Custom builder on error/fetch failure
  final Widget Function(BuildContext context, Object? error)? errorBuilder;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: SizedBox(
        width: width,
        height: height,
        child: FutureBuilder<Uint8List?>(
          future: ipfs.getImageBytes(cidOrFolder, fileName),
          builder: (context, snapshot) {
            // Loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingBuilder?.call(context) ?? placeholder ?? Container(color: Colors.grey[200]);
            }

            // Error state
            if (snapshot.hasError || snapshot.data == null) {
              return errorBuilder?.call(context, snapshot.error) ??
                  placeholder ??
                  Image.asset(
                    Assets.images.assets.mosaicBackground.path,
                    fit: fit,
                    width: width,
                    height: height,
                  );
            }

            // Success: display image
            return Image.memory(
              snapshot.data!,
              fit: fit,
              width: width,
              height: height,
            );
          },
        ),
      ),
    );
  }
}
