import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/core/utils/language.dart';
import 'package:thimar/feture/home/cubit/home_cubit.dart';
import 'package:thimar/feture/home/cubit/home_state.dart';
import 'product_item.dart';

class HomeProductsSection extends StatelessWidget {
  const HomeProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              context.l10n.items,
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
          buildWhen: (previous, current) =>
              current is GetProductsLoading ||
              current is GetProductsSuccess ||
              current is GetProductsError,
          builder: (context, state) {
            if (state is GetProductsLoading) {
              return const SizedBox(
                height: 200,
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              );
            } else if (state is GetProductsSuccess) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.65,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final item = state.products[index];
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
            } else if (state is GetProductsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(state.message),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}