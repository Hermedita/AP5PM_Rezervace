import 'dart:async';
import 'package:flutter/material.dart';

class SlideItem {
  final String image;
  final String? name;
  final String? place;
  final VoidCallback? onTap;

  const SlideItem({required this.image, this.name, this.place, this.onTap});
}

class ImageSlideshow extends StatefulWidget {
  const ImageSlideshow({
    super.key,
    required this.slides,
    this.height = 200,
    this.autoPlay = true,
    this.interval = const Duration(seconds: 4),
    this.borderRadius = 16,
  });

  final List<SlideItem> slides;
  final double height;
  final bool autoPlay;
  final Duration interval;
  final double borderRadius;

  @override
  State<ImageSlideshow> createState() => _ImageSlideshowState();
}

class _ImageSlideshowState extends State<ImageSlideshow> {
  final _controller = PageController();
  Timer? _timer;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    if (widget.autoPlay && widget.slides.length > 1) {
      _timer = Timer.periodic(widget.interval, (_) {
        final next = (_current + 1) % widget.slides.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        loadingBuilder: (context, child, progress) => progress == null
            ? child
            : const Center(child: CircularProgressIndicator()),
        errorBuilder: (context, error, stack) =>
        const Center(child: Icon(Icons.broken_image, size: 48)),
      );
    }
    return Image.asset(path, fit: BoxFit.cover, width: double.infinity);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.slides.isEmpty) return const SizedBox.shrink();

    return Container(
        height: widget.height,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),

      child: Stack(
        children: [
          //child
          PageView.builder(
            controller: _controller,
            itemCount: widget.slides.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (context, i) {
              final slide = widget.slides[i];
              return GestureDetector(
                onTap: slide.onTap,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _buildImage(slide.image),

                    if (slide.name != null || slide.place != null)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          color: Colors.black54,
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (slide.name != null)
                                Text(
                                  slide.name!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              if (slide.place != null)
                                Text(
                                  slide.place!,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],

                ),
              );
            },
          ),
          // Dot indicators
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.slides.length, (i) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: i == _current ? Colors.white : Colors.white54,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}