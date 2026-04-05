import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;

  final VoidCallback? onLogout;

  final VoidCallback? onBack;
  final PreferredSizeWidget? bottom;

  const CommonAppBar({
    super.key,
    this.title,
    this.showBackButton = false,
    this.onLogout,
    this.onBack,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
      ),

      backgroundColor: Colors.blue,

      ///  Back
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, size: 22.sp),
              onPressed: onBack ?? () => Navigator.pop(context),
            )
          : null,

      /// 🏷 Title
      title: Text(
        title ?? "",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
      ),

      ///  Logout (ONLY if provided)
      actions: onLogout != null
          ? [
              Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: IconButton(
                  icon: Icon(Icons.logout, size: 22.sp),
                  onPressed: onLogout,
                ),
              ),
            ]
          : [],

      bottom: bottom,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(56.h + (bottom?.preferredSize.height ?? 0));
}
