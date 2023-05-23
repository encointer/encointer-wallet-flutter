part of '../scan_page.dart';

/// Widget that rebuilds itself upon new stream data.
/// This is used in integration tests when we tell
/// the driver to restart the widget with new data.
class RestartWidget<T> extends StatelessWidget {
  const RestartWidget({
    super.key,
    required this.stream,
    required this.builder,
    required this.initialData,
  });

  final T initialData;
  final Stream<T> stream;
  final Widget Function(BuildContext, T) builder;

  Stream<T?> _invalidate(T? config) async* {
    yield null;
    await Future<dynamic>.delayed(const Duration(milliseconds: 16));
    yield config!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      initialData: initialData,
      builder: (context, snapshot) {
        return StreamBuilder(
          initialData: snapshot.data,
          stream: _invalidate(snapshot.data),
          builder: (context, snapshot) {
            return snapshot.data != null ? builder(context, snapshot.data as T) : const SizedBox();
          },
        );
      },
    );
  }
}

class MockQRScanPage extends StatelessWidget {
  const MockQRScanPage(this.background, {super.key});

  // image that emulates camera
  final ImageProvider background;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(image: background, fit: BoxFit.cover),
          ),
        ),
        SafeArea(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor),
            onPressed: () {},
          ),
        ),
        //overlays a semi-transparent rounded square border that is 90% of screen width
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.white38, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                ),
              ),
              const Text(
                'Scan Qr Code',
                style: TextStyle(color: Colors.white38),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
