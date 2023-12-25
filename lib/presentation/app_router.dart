import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/business_logic/cubits/pick_order_cubit.dart';
import 'package:shipper_app/business_logic/cubits/withdraw_history_cubit.dart';
import 'package:shipper_app/business_logic/repositories/pick_order_repository.dart';
import 'package:shipper_app/business_logic/repositories/withdraw_history_repository.dart';
import 'package:shipper_app/data/repositories/api/order_detail_api_repository.dart';
import 'package:shipper_app/data/repositories/socket/pick_order_socket_repository.dart';
import 'package:shipper_app/presentation/pages/initial_page.dart';
import 'package:shipper_app/presentation/screens/auth_failure_screen.dart';
import 'package:shipper_app/presentation/screens/list_order_screen.dart';
import 'package:shipper_app/presentation/screens/order_detail_screen.dart';
import 'package:shipper_app/presentation/screens/pick_order_screen.dart';
import 'package:shipper_app/presentation/screens/withdraw_history_screen.dart';
import '../business_logic/cubits/order_detail_cubit.dart';
import '../business_logic/repositories/order_detial_repository.dart';
import '../data/repositories/api/auth_api_repository.dart';
import '../data/repositories/api/setting_api_repository.dart';
import '../data/repositories/api/withdraw_history_api_repository.dart';
import 'screens/setting_screen.dart';
import 'screens/splash_screen.dart';
import '../business_logic/cubits/auth_cubit.dart';
import '../business_logic/cubits/setting_cubit.dart';
import '../business_logic/repositories/auth_repository.dart';
import '../business_logic/repositories/setting_repository.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String accountFailure = '/account-failure';
  static const String withdrawHistory = '/withdraw-history';
  static const String home = '/home';
  static const String listOrder = '/orders';

  static const String setting = '/setting';

  static const String orders = '/orders';
  static const String detailOrder = '/detail-order';
  static const String pickOrders = '/pick-orders';

  static Route<dynamic>? onGenerateAppRoute(
    RouteSettings settings,
    bool hasInternet,
  ) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) {
            return const SplashScreen();
          },
        );
      case auth:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<AuthRepository>(
              create: (context) => AuthApiRepository(),
              child: BlocProvider<AuthCubit>(
                create: (context) => AuthCubit(
                  repository: RepositoryProvider.of<AuthRepository>(
                    context,
                  ),
                ),
                child: const LoginScreen(),
              ),
            );
          },
        );
      case accountFailure:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<AuthRepository>(
              create: (context) => AuthApiRepository(),
              child: BlocProvider<AuthCubit>(
                create: (context) => AuthCubit(
                  repository: RepositoryProvider.of<AuthRepository>(
                    context,
                  ),
                ),
                child: const AuthFailureScreen(),
              ),
            );
          },
        );
      case home:
        return MaterialPageRoute(
          settings: RouteSettings(
            name: AppRouter.home,
            arguments: settings.arguments,
          ),
          builder: (context) {
            // Sửa provider khi có hoặc ko có mạng ở ngay đây
            // Ví dụ: RepositoryProvider<MemberRepository>(
            //           create: (context) => internet ? MemberMockRepository() : MemberLocalRepository(),
            //        )
            // return HomeScreen();
            return MultiRepositoryProvider(
              providers: [
                RepositoryProvider<SettingRepository>(
                  lazy: false,
                  create: (context) => SettingApiRepository(),
                ),
              ],
              child: MultiBlocProvider(
                providers: [
                  BlocProvider<SettingCubit>(
                    create: (context) => SettingCubit(
                      repository:
                          RepositoryProvider.of<SettingRepository>(context),
                    ),
                  ),
                ],
                child: const HomeScreen(),
              ),
            );
          },
        );
      case detailOrder:
        var id = settings.arguments;
        if (id is String) {
          return MaterialPageRoute(
            settings: RouteSettings(
              name: AppRouter.detailOrder,
              arguments: settings.arguments,
            ),
            builder: (context) {
              return RepositoryProvider<OrderDetailRepository>(
                create: (context) => OrderDetailApiRepository(),
                child: BlocProvider<OrderDetailCubit>(
                  create: (context) => OrderDetailCubit(
                    repository:
                        RepositoryProvider.of<OrderDetailRepository>(context),
                    id: id,
                  ),
                  child: const OrderDetailScreen(),
                ),
              );
            },
          );
        } else {
          return MaterialPageRoute(
              settings: RouteSettings(
                name: AppRouter.detailOrder,
                arguments: settings.arguments,
              ),
              builder: (context) {
                return const InitialPage();
              });
        }
      case listOrder:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<SettingRepository>(
              create: (context) => SettingApiRepository(),
              child: BlocProvider<SettingCubit>(
                create: (context) => SettingCubit(
                  repository: RepositoryProvider.of<SettingRepository>(context),
                ),
                child: const ListOrderScreen(),
              ),
            );
          },
        );
      case pickOrders:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<PickOrderRepository>(
              create: (context) => PickOrderSocketRepository(),
              child: BlocProvider<PickOrderCubit>(
                create: (context) => PickOrderCubit(
                  repository: RepositoryProvider.of<PickOrderRepository>(context),
                ),
                child: const PickOrderScreen(),
              ),
            );
          },
        );
      case withdrawHistory:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<WithdrawHistoryRepository>(
              create: (context) => WithdrawHistoryApiRepository(),
              child: BlocProvider<WithdrawHistoryCubit>(
                create: (context) => WithdrawHistoryCubit(
                  repository: RepositoryProvider.of<WithdrawHistoryRepository>(context),
                ),
                child: const WithdrawHistoryScreen(),
              ),
            );
          },
        );
      case setting:
        return MaterialPageRoute(
          builder: (context) {
            return RepositoryProvider<SettingRepository>(
              create: (context) => SettingApiRepository(),
              child: BlocProvider<SettingCubit>(
                create: (context) => SettingCubit(
                  repository: RepositoryProvider.of<SettingRepository>(context),
                ),
                child: const SettingScreen(),
              ),
            );
          },
        );
    }
    return null;
  }
}
