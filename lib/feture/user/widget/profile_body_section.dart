import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:thimar/core/cache/cache_helper.dart';
import 'package:thimar/core/gen/assets.gen.dart';
import 'package:thimar/core/route/routes.dart';
import 'package:thimar/feture/user/widget/profile_item_widget.dart';

class ProfileBodySection extends StatelessWidget {
  const ProfileBodySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          _buildSectionContainer([
            ProfileItem(
                title: "personalData".tr(),
                iconPath: Assets.icons.user,
                onTap: () {}),
            ProfileItem(
                title: "wallet".tr(),
                iconPath: Assets.icons.wallet,
                onTap: () {}),
            ProfileItem(
                title: "addresses".tr(),
                iconPath: Assets.icons.location,
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(Routes.addressesView);
                }),
            ProfileItem(
                title: "payment".tr(),
                iconPath: Assets.icons.payment,
                onTap: () {}),
          ]),
          const SizedBox(height: 16),
          _buildSectionContainer([
            ProfileItem(
              title: "faq".tr(),
              iconPath: Assets.icons.faq,
              onTap: () {},
            ),
            ProfileItem(
                title: "privacyPolicy".tr(),
                iconPath: Assets.icons.privacy,
                onTap: () {}),
            ProfileItem(
                title: "contactUs".tr(),
                iconPath: Assets.icons.contact,
                onTap: () {}),
            ProfileItem(
                title: "complaints".tr(),
                iconPath: Assets.icons.complaint,
                onTap: () {}),
            ProfileItem(
                title: "shareApp".tr(),
                iconPath: Assets.icons.share,
                onTap: () {}),
          ]),
          const SizedBox(height: 16),
          _buildSectionContainer([
            ProfileItem(
              title: "logout".tr(),
              iconPath: '',
              isLogout: true,
              onTap: () {
                CacheHelper.clearToken();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.loginView,
                  (route) => false,
                );
              },
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSectionContainer(List<Widget> children) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: List.generate(children.length, (index) {
          return Column(
            children: [
              children[index],
              if (index != children.length - 1)
                Divider(color: Colors.grey.withOpacity(0.1), height: 1),
            ],
          );
        }),
      ),
    );
  }
}
