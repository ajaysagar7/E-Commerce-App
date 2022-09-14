import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeCategoriesCard extends StatelessWidget {
  const ShimmeCategoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 200.h,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12.r)),
          )),
    );
  }
}
