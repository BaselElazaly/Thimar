import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thimar/core/services/local_cubit.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/core/utils/language.dart';
import 'package:thimar/feture/address/cubit/address_cubit.dart';
import 'package:thimar/feture/address/cubit/address_states.dart';
import 'package:thimar/feture/address/widget/add_address_button.dart';
import 'package:thimar/feture/address/widget/address_item.dart';

class AddressesView extends StatelessWidget {
  const AddressesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AddressCubit>()..getAddresses(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            context.l10n.addresses,
            style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          leading: Padding(
            padding: const EdgeInsetsDirectional.only(start: 16),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Center(
                child: SizedBox(
                  width: 32,
                  height: 32,
                  child: BlocBuilder<LocaleCubit, Locale>(
                    builder: (context, locale) {
                      return Transform.rotate(
                        angle: locale.languageCode == 'ar' ? 0 : math.pi,
                        child: SvgPicture.asset(
                          'assets/icons/back_arrow.svg',
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Builder(
          builder: (context) {
            return RefreshIndicator(
              backgroundColor: Colors.white,
              elevation: 2,
              color: AppColors.primary,
              onRefresh: () async {
                await context
                    .read<AddressCubit>()
                    .getAddresses(isRefresh: true);
              },
              child: BlocBuilder<AddressCubit, AddressStates>(
                builder: (context, state) {
                  final cubit = context.read<AddressCubit>();

                  if (state is GetAddressesLoadingState &&
                      cubit.addresses.isEmpty) {
                    return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.primary),
                    );
                  }

                  return CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      if (cubit.addresses.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(),
                              Center(child: Text(context.l10n.noAddresses)),
                              const Spacer(),
                              const AddAddressButton(),
                              const SizedBox(height: 40),
                            ],
                          ),
                        )
                      else ...[
                        SliverPadding(
                          padding: const EdgeInsets.all(16.0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child:
                                    AddressItem(model: cubit.addresses[index]),
                              ),
                              childCount: cubit.addresses.length,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: AddAddressButton(),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 40)),
                      ],
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
