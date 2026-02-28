import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/core/utils/language.dart';
import 'package:thimar/feture/home/cubit/home_cubit.dart';
import 'package:thimar/feture/home/cubit/home_state.dart';

class HomeSliderSection extends StatefulWidget {
  const HomeSliderSection({super.key});

  @override
  State<HomeSliderSection> createState() => _HomeSliderSectionState();
}

class _HomeSliderSectionState extends State<HomeSliderSection> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeSliderLoading ||
          current is HomeSliderSuccess ||
          current is HomeSliderError,
      builder: (context, state) {
        if (state is HomeSliderLoading) {
          return SizedBox(
            height: screenHeight * 0.2,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        } else if (state is HomeSliderSuccess) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CarouselSlider.builder(
                itemCount: state.sliders.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(state.sliders[index].media),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        context.l10n.permanentOffers,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: screenHeight * 0.2,
                  autoPlay: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() => activeIndex = index);
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                child: AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: state.sliders.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 8,
                    dotHeight: 8,
                    activeDotColor: Colors.white,
                    dotColor: Colors.white.withOpacity(0.38),
                  ),
                ),
              ),
            ],
          );
        } else if (state is HomeSliderError) {
          return SizedBox(
            height: screenHeight * 0.2,
            child: Center(child: Text(state.message)),
          );
        }
        return const SizedBox();
      },
    );
  }
}
