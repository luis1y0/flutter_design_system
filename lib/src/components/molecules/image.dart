import 'package:flutter/material.dart';

class DSImage extends StatefulWidget {
  final String src;
  const DSImage({
    required this.src,
    super.key,
  });

  @override
  State<DSImage> createState() => _DSImageState();
}

class _DSImageState extends State<DSImage> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.src,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Text('Couldn\'t load this image'),
        );
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        int total = loadingProgress.expectedTotalBytes ??
            loadingProgress.cumulativeBytesLoaded;
        int loaded = loadingProgress.cumulativeBytesLoaded;
        double progress = loaded / total;
        return CircularProgressIndicator(
          value: progress == 1.0 ? null : progress,
        );
      },
    );
  }
}
