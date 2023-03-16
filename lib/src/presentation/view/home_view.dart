import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/components/custom_text_form_field.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController(text: 'qewqeqweqwewq');

    return Scaffold(
      body: _buildBody(
        searchController: searchController,
      ),
    );
  }

  Widget _buildBody({
    required TextEditingController searchController,
  }) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 150.h,
            width: 300.w,
            child: CustomTextFormField(
              controller: searchController,
              validator: null,
              hintText: 'Search',
              fillColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
