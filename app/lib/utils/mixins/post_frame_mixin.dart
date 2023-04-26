import 'package:flutter/material.dart';

/// I've seen we use [WidgetsBinding.instance.addPostFrameCallback]
/// a lot through out the project
/// we could use this mixin instead
/// this is just an example
mixin PostFrameMixin<T extends StatefulWidget> on State<T> {
  void postFrame(void Function() callback) => WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          // Execute callback if page is mounted
          if (mounted) callback();
        },
      );
}
