import 'package:betalent/app/utils/dio_config.dart';
import 'package:flutter/material.dart';

import 'app/app_load_widget.dart';
import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppLoadWidget());

  /// Simulate a delay to check the server
  await Future.delayed(const Duration(seconds: 3));

  final (response, isCache) = await fetchData("http://localhost:5555/hello");
  if (response.statusCode == 200) {
    runApp(const AppWidget(isConnect: true));
  } else {
    runApp(const AppWidget(isConnect: false));
  }
}
