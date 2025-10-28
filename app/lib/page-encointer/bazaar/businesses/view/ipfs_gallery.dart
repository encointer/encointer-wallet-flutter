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

    showDialog<void>(
      context: context,
      builder: (_) => _FullScreenGallery(
        images: _images,
        initialIndex: initialIndex,
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
          return GestureDetector(
            onTap: () => _showFullScreenGallery(i),
            child: ClipRRect(
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
            ),
          );
        },
      ),
    );
  }
}

/// Full-screen swipeable gallery overlay with page indicator
class _FullScreenGallery extends StatefulWidget {

  const _FullScreenGallery({
    required this.images,
    required this.initialIndex,
  });
  final List<IpfsImageItem> images;
  final int initialIndex;

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
      child: Container(
        color: Colors.black.withOpacity(0.85),
        alignment: Alignment.center,
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: widget.images.length,
              onPageChanged: (index) => setState(() => _currentIndex = index),
              itemBuilder: (context, index) {
                final img = widget.images[index];
                return InteractiveViewer(
                  child: img.hasData
                      ? Image.memory(img.bytes!, fit: BoxFit.contain)
                      : const SizedBox.shrink(),
                );
              },
            ),
            // Page indicator at bottom center
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
      ),
    );
  }
}
