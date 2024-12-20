import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'datasources/datasource.dart';
import 'datasources/mock_datasource.dart';
import 'datasources/remote_datasource.dart';
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
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        home: Consumer<DataSource>(builder: (context, dataSource, _) {
          return Banner(
            location: BannerLocation.bottomStart,
            color: BeTheme.bluePrimary,
            message: switch (dataSource) {
              MockDatasource() => 'Mock',
              RemoteDataSource() => 'Remote',
              _ => 'Unknown',
            },
            child: const HomePage(),
          );
        }),
      ),
    );
  }
}
