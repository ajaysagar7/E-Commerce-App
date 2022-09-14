import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDetailsScreen extends StatelessWidget {
  const ShimmerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(
            flex: 1,
          ),
          //* row shimmer
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: 150.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(11.r)),
                    ),
                  ),
                ),
                const Spacer(),
                Flexible(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey.shade100,
                    child: Container(
                      width: 150.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(11.r)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),

          //* images shimmmer
          Flexible(
            flex: 5,
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.grey.shade100,
              child: Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.grey),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          //* text shimmer
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Container(
                    height: 20.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Flexible(
                  child: Container(
                    height: 20.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Flexible(
                  child: Container(
                    height: 20.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 20.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Container(
                  height: 20.h,
                  width: double.infinity - 10.w,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              ],
            ),
          ),
          const Spacer(),
          //* buttons shimmer
          Flexible(
            flex: 4,
            child: Column(
              children: [
                Flexible(
                  child: Container(
                    height: 60.h,
                    width: double.infinity - 20.w,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Flexible(
                  child: Container(
                    height: 60.h,
                    width: double.infinity - 20.w,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12.r)),
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
