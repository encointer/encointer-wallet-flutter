import 'package:flutter_driver/driver_extension.dart';
import 'package:encointer_wallet/main.dart' as app;

void main() {
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main();
}