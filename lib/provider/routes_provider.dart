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
    // -------------------------
    // PAGE INTRO
    // -------------------------
    GoRoute(
      path: "/intro",
      builder: (context, state) => const IntroPage(),
    ),

    // -------------------------
    // PAGE LOGIN
    // -------------------------
    GoRoute(
      path: "/login",
      builder: (context, state) => const LoginPage(),
    ),

    // -------------------------
    // PAGE REGISTER
    // -------------------------
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

        // PAGE REPORT
        GoRoute(
          path: "/report",
          builder: (context, state) => const ReportPage(),
        ),

        // PAGE PROFILE
        GoRoute(
          path: "/profile",
          builder: (context, state) => const ProfilPage(),
        ),
      ],
    ),
  ],
);
