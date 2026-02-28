import 'package:get_it/get_it.dart';
import 'package:thimar/feture/address/cubit/address_cubit.dart';
import 'package:thimar/feture/home/cubit/home_cubit.dart';
import 'package:thimar/feture/user/cubit/user_cubit.dart';
import 'server_gate.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => ServerGate());

  getIt.registerFactory(() => HomeCubit(getIt<ServerGate>())
    ..getSliders()
    ..getProducts());

  getIt.registerFactory(() => ProfileCubit(getIt<ServerGate>()));

  getIt.registerFactory(() => AddressCubit(getIt<ServerGate>()));
}
