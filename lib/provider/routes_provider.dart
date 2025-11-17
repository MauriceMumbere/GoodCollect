import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:goodcollect/pages/auth/login_page.dart';
import 'package:goodcollect/pages/auth/register_page.dart';
import 'package:goodcollect/pages/home_page.dart';
import 'package:goodcollect/pages/intro_page.dart';
import 'package:goodcollect/pages/profil_page.dart';


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
      builder: (context, state) => const LoginPage(), // c'est en rouge pourquoi
    ),

    // -------------------------
    // PAGE REGISTER
    // -------------------------
    GoRoute(
      path: "/register",
      builder: (context, state) => const RegisterPage(), // c'est en rouge pourquoi
    ),

    // -------------------------
    // PAGE HOME
    // -------------------------
    GoRoute(
      path: "/home",
      builder: (context, state) => const HomePage(),
    ),

    // -------------------------
    // PAGE PROFILE
    // -------------------------
    GoRoute(
      path: "/profile",
      builder: (context, state) => const ProfilPage(),
    ),
  ],
);
