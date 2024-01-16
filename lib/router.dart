import 'package:flutter/material.dart';
import 'package:food_app/features/auth/screen/forgot_passcode_screen.dart';
import 'package:food_app/features/cart/screen/cart_screen.dart';
import 'package:food_app/features/auth/screen/login_screen.dart';
import 'package:food_app/features/checkout/screen/checkout_delivery.dart';
import 'package:food_app/features/checkout/screen/checkout_payment.dart';
import 'package:food_app/features/home/screen/bottom_nav.dart';
import 'package:food_app/features/orders/screen/order_screen.dart';
import 'package:food_app/features/product/screen/product_detail.dart';
import 'package:food_app/features/product/screen/see_more.dart';
import 'package:food_app/features/user_profile/screen/edit_user_profile_screen.dart';
import 'package:food_app/features/user_profile/screen/user_profile_screen.dart';
import 'package:routemaster/routemaster.dart';

//loged out route
final logedOutRoute = RouteMap(
  routes: {
    '/': (_) => const MaterialPage(
          child: LoginScreen(),
        ),
    '/reset-passcode': (route) => const MaterialPage(
          child: ForgotPasscode(),
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
    '/user-profile/:uid': (route) => MaterialPage(
          child: UserProfileScreen(
            uid: route.pathParameters['uid']!,
          ),
        ),
    '/edit-profile/:uid': (route) => MaterialPage(
          child: EditUserProfile(uid: route.pathParameters['uid']!),
        ),
    '/checkout-delivery': (route) => const MaterialPage(
          child: CheckoutDelivery(),
        ),
    '/checkout-delivery/checkout-payment': (route) => const MaterialPage(
          child: CheckoutPayment(),
        ),
    '/orders/:uid': (route) => MaterialPage(
          child: OrderScreen(uid: route.pathParameters['uid']!),
        ),
  },
);
