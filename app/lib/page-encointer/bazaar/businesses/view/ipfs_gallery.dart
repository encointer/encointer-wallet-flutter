import 'dart:async';
import 'package:encointer_wallet/service/ipfs/ipfs_gallery_stream.dart';
import 'package:flutter/material.dart';
import 'package:encointer_wallet/service/ipfs/ipfs_api.dart';

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

  void _showFullScreenGallery(int initialIndex) {
    if (_images.isEmpty) return;

    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => _FullScreenGallery(
          images: _images,
          initialIndex: initialIndex,
          thumbnailWidth: widget.imageWidth,
          thumbnailHeight: widget.imageHeight,
          borderRadius: widget.borderRadius,
        ),
      ),
    );
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
          final heroTag = img.cidOrFolder + (img.fileName ?? '');
          return GestureDetector(
            onTap: () => _showFullScreenGallery(i),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: img.hasData
                  ? Hero(
                tag: heroTag,
                flightShuttleBuilder: (flightContext, animation, flightDirection,
                    fromHero, toHero) {
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (context, child) {
                      final radius = widget.borderRadius * (1 - animation.value);
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: child,
                      );
                    },
                    child: Image.memory(
                      img.bytes!,
                      width: widget.imageWidth,
                      height: widget.imageHeight,
                      fit: BoxFit.cover,
                    ),
                  );
                },
                child: Image.memory(
                  img.bytes!,
                  width: widget.imageWidth,
                  height: widget.imageHeight,
                  fit: BoxFit.cover,
                ),
              )
                  : SizedBox(
                width: widget.imageWidth,
                height: widget.imageHeight,
                child: widget.placeholder,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FullScreenGallery extends StatefulWidget {
  const _FullScreenGallery({
    required this.images,
    required this.initialIndex,
    required this.thumbnailWidth,
    required this.thumbnailHeight,
    required this.borderRadius,
  });

  final List<IpfsImageItem> images;
  final int initialIndex;
  final double thumbnailWidth;
  final double thumbnailHeight;
  final double borderRadius;

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery> {
  late PageController _controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: _currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Stack(
        children: [
          // Fade-in black background
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            color: Colors.black.withOpacity(0.85),
          ),
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final img = widget.images[index];
              final heroTag = img.cidOrFolder + (img.fileName ?? '');
              return Center(
                child: img.hasData
                    ? Hero(
                  tag: heroTag,
                  child: InteractiveViewer(
                    child: Image.memory(
                      img.bytes!,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
                    : const SizedBox.shrink(),
              );
            },
          ),
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_currentIndex + 1} / ${widget.images.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
