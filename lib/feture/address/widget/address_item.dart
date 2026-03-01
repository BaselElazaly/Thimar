import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thimar/core/utils/app_colors.dart';
import 'package:thimar/core/utils/language.dart';
import 'package:thimar/feture/address/cubit/address_cubit.dart';
import 'package:thimar/model/adderss_model.dart';

class AddressItem extends StatelessWidget {
  final AddressModel model;
  const AddressItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.primary),
      ),
      child: Row(
        children: [
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                model.type == 'work'
                    ? context.l10n.workLocation
                    : context.l10n.homeLocation,
                style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "${context.l10n.location} : ${model.location}",
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "${context.l10n.description} : ${model.description}",
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w300),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  "${context.l10n.phoneNumber} : +${model.phone}",
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ]),
          ),
          InkWell(
            onTap: () {
              context.read<AddressCubit>().deleteAddress(model.id);
            },
            child: SvgPicture.asset(
              'assets/icons/delete.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            'assets/icons/edit.svg',
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
