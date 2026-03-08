import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/feture/home/cubit/home_cubit.dart';
import 'package:thimar/feture/home/cubit/home_state.dart';
import 'package:thimar/feture/home/widgets/product_shimmer.dart';
import 'package:thimar/model/product_model.dart';
import 'product_item.dart';

class HomeProductsSection extends StatelessWidget {
  const HomeProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<HomeCubit>();
    return Column(
      children: [
        Row(
          children: [
            Text(
              "items".tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.black,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        BlocBuilder<HomeCubit, HomeState>(
          bloc: cubit,
          buildWhen: (previous, current) =>
              current is GetProductsLoading ||
              current is GetProductsSuccess ||
              current is GetProductsError ||
              current is SearchLoadingState ||
              current is SearchSuccessState ||
              current is SearchErrorState,
          builder: (context, state) {
            if (state is GetProductsLoading || state is SearchLoadingState) {
             return const ProductShimmer();
            }
            List<ProductModel> displayList = [];
            if (state is SearchSuccessState) {
              displayList = state.products;
            } else if (state is SearchLoadingState) {
              displayList = [];
            } else {
              displayList = cubit.products;
            }
            if (displayList.isEmpty &&
                (state is SearchSuccessState || state is SearchLoadingState)) {
              if (state is SearchSuccessState) {
                return SizedBox(
                  height: 200,
                  child: Center(child: Text("no_results_found".tr())),
                );
              }
              return const SizedBox();
            }
            if (state is GetProductsError || state is SearchErrorState) {
              return Center(child: Text("default_error".tr()));
            }
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 15,
                childAspectRatio: 0.65,
              ),
              itemCount: displayList.length,
              itemBuilder: (context, index) {
                final item = displayList[index];
                return ProductItem(
                  imagePath: item.mainImage,
                  title: item.title,
                  discount: "${(item.discount * 100).toInt()}",
                  unit: item.unitName,
                  priceBeforeDiscount: "${item.priceBeforeDiscount}",
                  priceAfterDiscount: "${item.price}",
                );
              },
            );
          },
        ),
      ],
    );
  }
}
