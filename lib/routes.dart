import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/routes.dart';
import 'package:instore/screens/home_screen.dart';
import 'package:instore/screens/messages_screen.dart';
import 'package:instore/screens/product_screen.dart';
import 'package:instore/screens/profil_screen.dart';
import 'package:instore/screens/splash_screen.dart';
import 'package:instore/screens/login_instascreen.dart';
import 'package:instore/screens/sign_upinstascreen.dart';


List<GetPage<dynamic>> routes=[
  GetPage(
    name: '/',
    page: () => const SplashScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/login',
    page: () => LoginInstaScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/signup',
    page: () => const SignUpInstaScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/home',
    page: () => const HomeView(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/profile',
    page: () => const ProfilScreen(),
    transition: Transition.rightToLeft,

    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/messages',
    page: () => const MessageScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/product',
    page: () => const InstagramProduit(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 700),
  ),



];