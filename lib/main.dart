import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'route/routes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'money note',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: false),
//      theme: ThemeData(brightness: Brightness.dark),
//      home: HomeScreen(),
    );
  }
}
