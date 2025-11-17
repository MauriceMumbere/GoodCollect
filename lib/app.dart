import 'package:flutter/material.dart';
import 'package:goodcollect/provider/routes_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: appRouter, // 👈 c'est ici que GoRouter est pris en compte
    );
  }
}
