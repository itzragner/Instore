import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instore/routes.dart';
import 'package:instore/screens/donnes_screen.dart';
import 'package:instore/screens/home_screen.dart';
import 'package:instore/screens/home_screen2.dart';
import 'package:instore/screens/messages_screen.dart';
import 'package:instore/screens/product_screen.dart';
import 'package:instore/screens/profil_screen.dart';
import 'package:instore/screens/Auth/splash_screen.dart';
import 'package:instore/screens/Auth/login_instascreen.dart';
import 'package:instore/screens/Auth/sign_upinstascreen.dart';


List<GetPage<dynamic>> routes=[
  GetPage(
    name: '/',
    page: () => const SplashScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/login',
    page: () => LoginInstaScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/signup',
    page: () => const SignUpInstaScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/home',
    page: () => const HomeView(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/home2',
    page: () => const HomeView2(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/profile',
    page: () => const ProfilScreen(),
    transition: Transition.rightToLeft,

    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/messages',
    page: () => const MessageScreen(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/product',
    page: () => const InstagramProduit(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/Donnes',
    page: () => const DonnesScreen(),
    transition: Transition.rightToLeft,

    transitionDuration: const Duration(milliseconds: 500),
  ),



];