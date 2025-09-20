import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';

class BuildSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const BuildSearchBar({super.key, required this.onSearch});

  @override
  State<BuildSearchBar> createState() => _BuildSearchBarState();
}

class _BuildSearchBarState extends State<BuildSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: TextField(
        controller: _controller,
        onChanged: widget.onSearch,
        decoration: InputDecoration(
          hintText: "Ask Meta AI or Search",
          prefixIcon: Icon(Icons.search, size: 25.sp, color: AppColors.grey),
          filled: true,
          fillColor: Colors.grey[200],
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}