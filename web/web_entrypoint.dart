import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:depi227/main.dart' as app;

void main() async {
  setUrlStrategy(PathUrlStrategy());
  app.main();
}
