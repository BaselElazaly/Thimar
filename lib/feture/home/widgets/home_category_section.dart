import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/feture/home/cubit/home_cubit.dart';
import 'package:thimar/feture/home/cubit/home_state.dart';
import 'package:thimar/feture/home/widgets/category_box.dart';

class HomeCategoriesSection extends StatelessWidget {
  const HomeCategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => 
          current is GetCategoriesSuccess || current is GetCategoriesLoading || current is GetCategoriesError,
      builder: (context, state) {
        if (state is GetCategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        final cubit = context.read<HomeCubit>();

        return Column(
          children: [
            Row(
              children: [
                Text("categories".tr(), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                const Spacer(),
                Text("viewAll".tr(), style: const TextStyle(color: AppColors.primary, fontSize: 15)),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: cubit.categories.length,
                itemBuilder: (context, index) => CategoryBox(model: cubit.categories[index]),
                separatorBuilder: (context, index) => const SizedBox(width: 16),
              ),
            ),
          ],
        );
      },
    );
  }
}