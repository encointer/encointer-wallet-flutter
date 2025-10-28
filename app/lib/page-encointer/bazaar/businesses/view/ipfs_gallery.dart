import 'dart:async';

import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_gallery_stream.dart';
import 'package:flutter/material.dart';

class IpfsImageGallery extends StatefulWidget {
  const IpfsImageGallery({
    super.key,
    required this.ipfs,
    required this.cidsOrFolders,
    this.includeFiles,
    this.imageWidth = 120,
    this.imageHeight = 120,
    this.borderRadius = 8,
    this.placeholder = const ColoredBox(color: Colors.grey),
    this.maxConcurrent = 4,
  });

  final IpfsApi ipfs;
  final List<String> cidsOrFolders;
  final Map<String, List<String>>? includeFiles;
  final double imageWidth;
  final double imageHeight;
  final double borderRadius;
  final Widget placeholder;
  final int maxConcurrent;

  @override
  State<IpfsImageGallery> createState() => _IpfsImageGalleryState();
}

class _IpfsImageGalleryState extends State<IpfsImageGallery> {
  final List<IpfsImageItem> _images = [];
  StreamSubscription<IpfsImageItem>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = widget.ipfs
        .streamGalleryImagesQueued(
      cidsOrFolders: widget.cidsOrFolders,
      includeFiles: widget.includeFiles,
      maxConcurrent: widget.maxConcurrent,
    )
        .listen((item) {
      setState(() => _images.add(item));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.imageHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: _images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final img = _images[i];
          return ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: img.hasData
                ? Image.memory(
              img.bytes!,
              width: widget.imageWidth,
              height: widget.imageHeight,
              fit: BoxFit.cover,
            )
                : SizedBox(
              width: widget.imageWidth,
              height: widget.imageHeight,
              child: widget.placeholder,
            ),
          );
        },
      ),
    );
  }
}
