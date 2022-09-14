import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/View_Models/providers/categorey_provider/categories_provider.dart';
import 'package:shopping_app/View_Models/providers/products_provider/products_provider.dart';
import 'package:shopping_app/Views/constants/app_constants.dart';
import 'package:shopping_app/Views/shimmer/categories_card.dart';
import 'package:shopping_app/Views/widgets/category_widget/custom_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CategoreisProvider>().getCategoreis();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.allCategories),
        ),
        body: Consumer<CategoreisProvider>(builder: (context, model, _) {
          if (model.state == CategoryState.failed) {
            return Center(
              child: Text(model.error.toString()),
            );
          } else if (model.state == CategoryState.loading) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 180,
                      height: 30.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.grey),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: 10,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (c, i) {
                        return const ShimmeCategoriesCard();
                      }),
                ),
              ],
            );
          } else if (model.state == CategoryState.loaded) {
            return const CategoryBodyWidget();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }));
  }
}

class CategoryBodyWidget extends StatelessWidget {
  const CategoryBodyWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.allCategories,
            style: getBoldStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Expanded(child: CategoryWidget())
        ],
      ),
    );
  }
}
