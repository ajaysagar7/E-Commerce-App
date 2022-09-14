import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerProductCard extends StatelessWidget {
  const ShimmerProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.grey.shade100,
            child: Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12.r)),
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 80.w,
                      height: 16.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: 10.h,
                  ),
                ),
                Flexible(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 120.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
