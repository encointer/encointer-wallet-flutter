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
    this.tapScale = 1.04,
    this.tapAnimationDuration = const Duration(milliseconds: 80),
    this.tapDelay = const Duration(milliseconds: 60),
  });

  final IpfsApi ipfs;
  final List<String> cidsOrFolders;
  final Map<String, List<String>>? includeFiles;
  final double imageWidth;
  final double imageHeight;
  final double borderRadius;
  final Widget placeholder;
  final int maxConcurrent;

  /// How much the thumbnail should "pop" when tapped (e.g., 1.0 → 1.04)
  final double tapScale;

  /// Duration of the tap animation (forward + reverse)
  final Duration tapAnimationDuration;

  /// Small delay before showing full-screen after tap animation
  final Duration tapDelay;

  @override
  State<IpfsImageGallery> createState() => _IpfsImageGalleryState();
}

class _IpfsImageGalleryState extends State<IpfsImageGallery> with SingleTickerProviderStateMixin {
  final List<IpfsImageItem> _images = [];
  StreamSubscription<IpfsImageItem>? _subscription;

  late AnimationController _tapController;
  late Animation<double> _tapAnimation;
  late Animation<double> _backgroundOpacity;
  int? _tappedIndex;

  @override
  void initState() {
    super.initState();
    _subscription = widget.ipfs
        .streamGalleryImagesQueued(
          cidsOrFolders: widget.cidsOrFolders,
          includeFiles: widget.includeFiles,
          maxConcurrent: widget.maxConcurrent,
        )
        .listen((item) => setState(() => _images.add(item)));

    _tapController = AnimationController(
      vsync: this,
      duration: widget.tapAnimationDuration,
    );

    _tapAnimation = Tween<double>(begin: 1, end: widget.tapScale).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeOutCubic),
    );

    _backgroundOpacity = Tween<double>(begin: 0, end: 0.6).animate(
      CurvedAnimation(parent: _tapController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _tapController.dispose();
    super.dispose();
  }

  Future<void> _onThumbnailTap(int index) async {
    setState(() => _tappedIndex = index);
    await _tapController.forward();
    await _tapController.reverse();

    await Future<void>.delayed(widget.tapDelay);
    setState(() => _tappedIndex = null);

    if (!mounted) return;
    _showFullScreenGallery(index);
  }

  void _showFullScreenGallery(int initialIndex) {
    if (_images.isEmpty) return;

    Navigator.of(context).push(
      PageRouteBuilder<void>(
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
        padding: const EdgeInsets.symmetric(),
        itemCount: _images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final img = _images[i];
          final heroTag = img.cidOrFolder + (img.fileName ?? '');

          Widget thumbnailWidget = ClipRRect(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: img.hasData
                ? Hero(
                    tag: heroTag,
                    flightShuttleBuilder: (flightContext, animation, flightDirection, fromHero, toHero) {
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
          );

          // Apply tap feedback only on tapped thumbnail
          if (_tappedIndex == i) {
            thumbnailWidget = AnimatedBuilder(
              animation: _tapController,
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      color: Colors.black.withAlpha((_backgroundOpacity.value * 255).toInt()),
                    ),
                    Transform.scale(scale: _tapAnimation.value, child: child),
                  ],
                );
              },
              child: thumbnailWidget,
            );
          }

          return GestureDetector(
            onTap: () => _onThumbnailTap(i),
            child: thumbnailWidget,
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
          Container(color: Colors.black.withAlpha((0.85 * 255).toInt())),
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
                          child: Image.memory(img.bytes!, fit: BoxFit.contain),
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
