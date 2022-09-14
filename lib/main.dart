import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/View_Models/providers/cart%20provider/cart_provider.dart';
import 'package:shopping_app/View_Models/providers/categorey_provider/categories_provider.dart';
import 'package:shopping_app/View_Models/providers/products_provider/products_provider.dart';
import 'package:shopping_app/View_Models/providers/wishlist_provider/wishlist_provider.dart';
import "Views/constants/app_constants.dart";

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c) => CategoreisProvider()),
          ChangeNotifierProvider(create: (c) => CartProvider()),
          // ChangeNotifierProvider(create: (c) => ProductsProvider()),
          ChangeNotifierProvider(create: (c) => WishListProvider()),
          ChangeNotifierProxyProvider<WishListProvider, ProductsProvider>(
            create: (c) => ProductsProvider(),
            update: ((context, value, previous) =>
                previous!..updateWishList(updatedList: value.wishList)),
          ),
        ],
        child: ScreenUtilInit(
          minTextAdapt: true,
          splitScreenMode: true,
          designSize: const Size(360, 800),
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Shopping App',
              theme: getApplicationTheme(),
              initialRoute: Routes.homeScreen,
              onGenerateRoute: RouteGenerator.getRoute,
            );
          },
        ));
  }
}
