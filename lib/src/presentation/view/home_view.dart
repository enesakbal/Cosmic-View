import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/gen/assets.gen.dart';
import '../../config/gen/colors.gen.dart';
import '../../core/components/custom_text_form_field.dart';
import '../_widget/apod/apod_bloc_widget.dart';
import '../_widget/nasa_image/nasa_image_bloc_widget.dart';
import '../_widget/nasa_image/nasa_image_card_list.dart';
import '../bloc/apod/apod_bloc.dart';
import '../bloc/nasa_image/nasa_image_bloc.dart';

class HomeView extends HookWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    useEffect(() {
      context.read<APODBloc>().add(const FetchApodData(count: 5));
      context.read<NasaImageBloc>().add(const FetchNasaImageData(count: 50));
      print('****');
      return null;
    }, []);

    return Scaffold(
      body: _buildBody(searchController: searchController),
    );
  }

  Widget _buildBody({
    required TextEditingController searchController,
  }) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.r),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverAppBar(
              centerTitle: true,
              pinned: false,
              snap: false,
              floating: true,
              title: _searchBox(searchController),
              backgroundColor: ColorTones.primary,
              toolbarHeight: 80.h,
              elevation: 0,
            ),
            SliverToBoxAdapter(child: _apodCarousel()),
            // SliverToBoxAdapter(
            //   child: _nasaImageCardList(),
            // ),
            SliverToBoxAdapter(child: 20.verticalSpace),
            _nasaImageCardList()

            // Container(
            //   alignment: Alignment.center,
            //   padding: EdgeInsets.symmetric(vertical: 50.h),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       _searchBox(searchController),
            //       50.verticalSpace,
            //       _apodCarousel(),
            //       _nasaImageCardList(),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _apodCarousel() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.r),
      child: const ApodBlocWidget(),
    );
  }

  Widget _nasaImageCardList() {
    return BlocBuilder<NasaImageBloc, NasaImageState>(
      builder: (context, state) {
        if (state is NasaImageHasData) {
          return NasaImageCardList(itemList: state.dataList);
        }
        return SliverToBoxAdapter(
          child: Container(),
        );
      },
    );
  }

  Widget _searchBox(TextEditingController searchController) {
    return CustomTextFormField(
      controller: searchController,
      validator: null,
      hintText: 'Search',
      // fillColor: Colors.white,
    );
  }
}
