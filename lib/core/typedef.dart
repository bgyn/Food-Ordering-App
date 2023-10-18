import 'package:food_app/core/faliure.dart';
import 'package:fpdart/fpdart.dart';

typedef FutureEither<T> = Future<Either<Faliure, T>>;
typedef FutureVoid<T> = FutureEither<void>;
