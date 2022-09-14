import 'package:flutter/material.dart';
import 'package:shopping_app/Views/constants/app_strings.dart';
import 'package:shopping_app/Views/screens/AllProduct/all_products.dart';
import 'package:shopping_app/Views/screens/Category%20Screen/category_screen.dart';

import '../screens/HomeScreen/home_screen.dart';

class Routes {
  static const String homeScreen = "/homescreen";
  static const String categoryScreen = "/categoryScreen";
  static const String allproductsScreen = "/allproductsScreen";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.categoryScreen:
        return MaterialPageRoute(builder: (_) => const CategoryScreen());
      case Routes.allproductsScreen:
        return MaterialPageRoute(builder: (_) => const AllProducts());

      default:
        return unDefinedRoute();
    }
  }
}

Route<dynamic> unDefinedRoute() {
  return MaterialPageRoute(
      builder: (_) => Scaffold(
            appBar: AppBar(title: const Text(AppStrings.unDefinedRoute)),
            body: const Center(child: Text(AppStrings.noRouteFound)),
          ));
}
