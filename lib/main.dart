import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/business_logic/cubits/account_cubit.dart';
import 'package:shipper_app/business_logic/cubits/geolocator_cubit.dart';

import 'business_logic/states/account_state.dart';
import 'data/repositories/storage/account_storage_repository.dart';
import 'business_logic/repositories/account_repository.dart';

import '../business_logic/cubits/internet_cubit.dart';
import 'presentation/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AccountRepository>(
      create: (context) => AccountStorageRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(),
          ),
          BlocProvider<GeolocatorCubit>(
            create: (context) => GeolocatorCubit(),
            lazy: false,
          ),
          BlocProvider<AccountCubit>(
            create: (context) => AccountCubit(
              repository: RepositoryProvider.of<AccountRepository>(
                context,
              ),
            ),
          ),
        ],
        child: BlocBuilder<AccountCubit, AccountState>(
          builder: (context, state) {
            return MaterialApp(
              key: ValueKey(state.toString()),
              // localizationsDelegates: [LocalizationsDelegate],
              title: 'Shipper App',
              theme: ThemeData(
                useMaterial3: false,
                scaffoldBackgroundColor: const Color.fromRGBO(244, 244, 244, 1),
                textTheme: const TextTheme(
                  titleLarge: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    height: 1.1,
                  ),
                  titleMedium: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    height: 1.25,
                  ),
                  titleSmall: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    height: 1.25,
                  ),
                  bodyLarge: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    fontWeight: FontWeight.w400,
                    height: 1.25,
                  ),
                  bodyMedium: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                  bodySmall: TextStyle(
                    fontSize: 12,
                    color: Colors.black87,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 1,
                ),
                primarySwatch: const MaterialColor(
                  0xFFFFC375,
                  {
                    50: Color(0xFFFFF4E2),
                    100: Color(0xFFFFE2B6),
                    200: Color(0xFFFFCF87),
                    300: Color(0xFFFFBC58),
                    400: Color(0xFFFFAD37),
                    500: Color(0xFFFF9E22),
                    600: Color(0xFFFB931F),
                    700: Color(0xFFF4841C),
                    800: Color(0xFFEE571A),
                    900: Color(0xFFE45C16),
                  },
                ),
              ),
              initialRoute: (state is AccountFailure)
                  ? AppRouter.accountFailure
                  : state is AccountLoaded
                      ? state.isLogin
                          ? AppRouter.home
                          : AppRouter.auth
                      : AppRouter.splash,
              onGenerateRoute: (settings) {
                return AppRouter.onGenerateAppRoute(
                  settings,
                  context.read<InternetCubit>().hasInternet,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
