import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/error_text.dart';
import 'package:food_app/core/common/loader.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';
import 'package:food_app/features/cart/controller/cart_controller.dart';
import 'package:food_app/features/favourite/controller/favourite_controller.dart';
import 'package:food_app/firebase_options.dart';
import 'package:food_app/model/user_model.dart';
import 'package:food_app/router.dart';
import 'package:food_app/theme/theme_palette.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;
  Future<UserModel?> getData(WidgetRef ref, String uid) async {
    ref.read(cartControllerProvider.notifier).createCart(context, uid);
    ref
        .read(favouriteControllerProvider.notifier)
        .intializeFavourite(context, uid);
    userModel =
        await ref.watch(authControllerProvider.notifier).getUserData(uid).first;
    ref.read(userProvider.notifier).update((state) => userModel);
    return userModel;
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
          data: (data) {
            if (data != null) {
              return FutureBuilder(
                future: getData(ref, data.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  return MaterialApp.router(
                    title: 'Food App',
                    debugShowCheckedModeBanner: false,
                    theme: ThemePallete.defaultAppTheme,
                    routeInformationParser: const RoutemasterParser(),
                    routerDelegate: RoutemasterDelegate(
                      routesBuilder: (context) {
                        if (snapshot.hasData) {
                          return logedInRoute;
                        } else {
                          return logedOutRoute;
                        }
                      },
                    ),
                  );
                },
              );
            } else {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'Food App',
                theme: ThemePallete.defaultAppTheme,
                routeInformationParser: const RoutemasterParser(),
                routerDelegate: RoutemasterDelegate(
                  routesBuilder: (context) {
                    return logedOutRoute;
                  },
                ),
              );
            }
          },
          error: (error, errorStack) {
            return ErrorText(text: error.toString());
          },
          loading: () => const Loader(),
        );
  }
}
