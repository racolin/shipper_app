import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shipper_app/business_logic/cubits/setting_cubit.dart';
import 'package:shipper_app/presentation/app_router.dart';
import 'package:shipper_app/presentation/pages/home_body.dart';
import 'package:shipper_app/presentation/pages/profile_page.dart';
import 'package:shipper_app/presentation/res/dimen/dimens.dart';
import 'package:shipper_app/presentation/screens/delivering_order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selected = 1;
  Widget? current;
  Widget? homePage;
  Widget? profilePage;

  void select(int i) {
    if (selected != i) {
      setState(() {
        selected = i;
        current = i == 0 ? homePage : profilePage;
      });
    }
  }

  @override
  void initState() {
    context.read<SettingCubit>().checkDelivering().then(
      (res) {
        // print('res?.orders.length');
        // print(res?.orders.length);
        if (res != null) {
          // print(res?.orders.length);
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: RouteSettings(arguments: res),
              builder: (ctx) {
                return BlocProvider.value(
                  value: BlocProvider.of<SettingCubit>(context),
                  child: const DeliveringOrderScreen(),
                );
              },
            ),
          );
        }
      },
    );

    homePage = const HomeBody();

    profilePage = const ProfilePage();

    select(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(spaceXXS),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(42 / 2),
              ),
              width: 42,
              height: 42,
              child: Image.asset(
                'assets/images/logo_shipper.png',
              ),
            ),
            const SizedBox(width: spaceSM),
            const Text(
              'Ứng dụng giao hàng!',
              style: TextStyle(
                fontSize: fontLG,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
      ),
      body: current,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.home_rounded,
                color: selected == 0 ? Colors.orange : Colors.black,
              ),
              onPressed: () {
                select(0);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.account_circle_rounded,
                color: selected == 1 ? Colors.orange : Colors.black,
              ),
              onPressed: () {
                select(1);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          context.read<SettingCubit>().checkDelivering().then(
                (res) {

                  // context.read<SettingCubit>().checkDelivering().then(
                  //       (res) {
                  //     if (res.isNotEmpty) {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           settings: RouteSettings(arguments: res),
                  //           builder: (ctx) {
                  //             return BlocProvider.value(
                  //               value: BlocProvider.of<SettingCubit>(context),
                  //               child: const DeliveringOrderScreen(),
                  //             );
                  //           },
                  //         ),
                  //       );
                  //     }
                  //   },
                  // );
              if (res != null && res.orders.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(arguments: res),
                    builder: (ctx) {
                      return BlocProvider.value(
                        value: BlocProvider.of<SettingCubit>(context),
                        child: const DeliveringOrderScreen(),
                      );
                    },
                  ),
                );
              } else {
                Navigator.pushNamed(context, AppRouter.pickOrders).then((e) {
                  context.read<SettingCubit>().checkDelivering().then(
                        (res) {
                          if (res != null && res.orders.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            settings: RouteSettings(arguments: res),
                            builder: (ctx) {
                              return BlocProvider.value(
                                value: BlocProvider.of<SettingCubit>(context),
                                child: const DeliveringOrderScreen(),
                              );
                            },
                          ),
                        );
                      }
                    },
                  );
                });
              }
            },
          );
        },
        child: const Icon(
          Icons.add_circle,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
