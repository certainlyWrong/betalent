import 'package:betalent/app/datasources/mock_datasource.dart';
import 'package:betalent/app/datasources/remote_datasource.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'utils/theme.dart';

class AppWidget extends StatefulWidget {
  final bool isConnect;
  const AppWidget({
    super.key,
    required this.isConnect,
  });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => widget.isConnect ? RemoteDataSource() : MockDatasource(),
      child: MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        home: const HomePage(),
      ),
    );
  }
}
