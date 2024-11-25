import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'utils/theme.dart';

class AppLoadWidget extends StatefulWidget {
  const AppLoadWidget({super.key});

  @override
  State<AppLoadWidget> createState() => _AppLoadWidgetState();
}

class _AppLoadWidgetState extends State<AppLoadWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      home: Scaffold(
        backgroundColor: BeTheme.bluePrimary,
        body: Center(
          child: SvgPicture.asset(
            'assets/logo.svg',
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}
