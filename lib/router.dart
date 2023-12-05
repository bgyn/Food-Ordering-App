import 'package:flutter/material.dart';
import 'package:food_app/features/cart/screen/cart_screen.dart';
import 'package:food_app/features/auth/screen/login_screen.dart';
import 'package:food_app/features/home/screen/bottom_nav.dart';
import 'package:food_app/features/product/screen/product_detail.dart';
import 'package:food_app/features/product/screen/see_more.dart';
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
    '/product-detail/:name': (route) => MaterialPage(
          child: ProductDetail(
            pid: route.pathParameters['name']!,
          ),
        ),
    '/cart': (route) => const MaterialPage(
          child: CartScreen(),
        ),
    '/see-more': (route) => const MaterialPage(
          child: SeeMore(),
        ),
  },
);
