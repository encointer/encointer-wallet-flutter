import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_gallery_stream.dart';
import 'package:flutter/material.dart';

class IpfsImageGalleryStream extends StatefulWidget {
  const IpfsImageGalleryStream({
    super.key,
    required this.ipfs,
    required this.cidsOrFolders,
    this.includeFiles,
    this.imageWidth = 120,
    this.imageHeight = 120,
    this.borderRadius = 8,
    this.placeholder = const ColoredBox(color: Colors.grey),
  });

  final IpfsApi ipfs;
  final List<String> cidsOrFolders;
  final Map<String, List<String>>? includeFiles;
  final double imageWidth;
  final double imageHeight;
  final double borderRadius;
  final Widget placeholder;


  @override
  State<IpfsImageGalleryStream> createState() => _IpfsImageGalleryStreamState();
}

class _IpfsImageGalleryStreamState extends State<IpfsImageGalleryStream> {
  final List<IpfsImageItem> _images = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  void _loadImages() {
    widget.ipfs
        .streamGalleryImagesQueued(
      cidsOrFolders: widget.cidsOrFolders,
      includeFiles: widget.includeFiles,
      maxConcurrent: 5
    )
        .listen((item) {
      setState(() => _images.add(item));
    }, onError: (e) => debugPrint('Error loading image: $e'));
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
