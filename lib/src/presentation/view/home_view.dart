import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/components/custom_text_form_field.dart';
import '../_widget/apod_carousel.dart';
import '../bloc/home/home_bloc.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    useEffect(() {
      context.read<HomeBloc>().add(const FetchApodData(count: 5));
      return null;
    }, []);

    return Scaffold(
      body: _buildBody(
        searchController: searchController,
      ),
    );
  }

  Widget _buildBody({
    required TextEditingController searchController,
  }) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 50.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _searchBox(searchController),
              50.verticalSpace,
              _apodCarousel(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _apodCarousel() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeHasData) {
          return APODCarousel(apodList: state.dataList);
        }
          return const APODCarousel(apodList: []);
      },
    );
  }

  Widget _searchBox(TextEditingController searchController) {
    return Container(
      width: 300.w,
      child: CustomTextFormField(
        controller: searchController,
        validator: null,
        hintText: 'Search',
        fillColor: Colors.white,
      ),
    );
  }
}
