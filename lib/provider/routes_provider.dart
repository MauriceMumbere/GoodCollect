import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goodcollect/pages/auth/login_page.dart';
import 'package:goodcollect/pages/auth/register_page.dart';
import 'package:goodcollect/pages/home_page.dart';
import 'package:goodcollect/pages/intro_page.dart';
import 'package:goodcollect/pages/profil_page.dart';
import 'package:goodcollect/pages/report_page.dart';


import '../widgets/map.dart';


final GoRouter appRouter = GoRouter(

  initialLocation: "/intro",

  routes: [

    GoRoute(
      path: "/intro",
      builder: (context, state) => const IntroPage(),
    ),

    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),

    GoRoute(
      path: "/register",
      builder: (context, state) => const RegisterPage()
    ),

    ShellRoute(
      builder: (context, state, child) {
        return HomePage(child: child);
      },
      routes: [
        GoRoute(
          path: "/home",
          builder: (context, state) => const MapPage(),
        ),

        GoRoute(
          path: "/report",
          builder: (context, state) => const ReportPage(),
        ),

        GoRoute(
          path: "/profile",
          builder: (context, state) => const ProfilPage(),
        ),
      ],
    ),
  ],
);
