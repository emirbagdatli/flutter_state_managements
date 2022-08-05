import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_state_managements/feature/maps/view/map_select_view.dart';
import 'package:flutter_state_managements/feature/onboard/onboard_view.dart';
import 'package:flutter_state_managements/feature/login/view/login_view.dart';
import 'package:flutter_state_managements/feature/travel/view/travel_tab_view.dart';
import 'package:flutter_state_managements/product/model/state/project_context.dart';
import 'package:flutter_state_managements/product/model/state/user_context.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          //
          //  Provider(create: (context) => UserContext('Emir')),
          ChangeNotifierProvider(create: (context) => ProductContext()),
          ProxyProvider<ProductContext, UserContext?>(
            update: (BuildContext context, productContext, userContext) {
              return userContext != null
                  ? userContext.copyWith(name: productContext.newUserName)
                  : UserContext(productContext.newUserName);
            },
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            home: const TravelTabView(),
            theme: ThemeData.light().copyWith(
                tabBarTheme: const TabBarTheme(
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.grey,
                  indicatorSize: TabBarIndicatorSize.label,
                ),
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.transparent, elevation: 0, systemOverlayStyle: SystemUiOverlayStyle.dark),
                scaffoldBackgroundColor: Colors.grey[100],
                floatingActionButtonTheme:
                    const FloatingActionButtonThemeData(backgroundColor: Color.fromRGBO(11, 23, 84, 1)))));
  }
}
