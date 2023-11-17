import 'package:flutter/material.dart';
import 'package:food_app/features/auth/screen/login_screen.dart';
import 'package:food_app/features/home/screen/bottom_nav.dart';
import 'package:routemaster/routemaster.dart';

//loged out route
final logedOutRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: LoginScreen(),
        ),
  },
);

//loged in route
final logedInRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: BottomNav(),
        ),
  },
);
