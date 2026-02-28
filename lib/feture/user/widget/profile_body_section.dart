import 'package:flutter/material.dart';
import 'package:thimar/core/cache/cache_helper.dart';
import 'package:thimar/core/route/routes.dart';
import 'package:thimar/core/utils/language.dart';
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
            ProfileItem(title: context.l10n.personalData, iconPath: 'assets/icons/user.svg', onTap: () {}),
            ProfileItem(title: context.l10n.wallet, iconPath: 'assets/icons/wallet.svg', onTap: () {}),
            ProfileItem(title: context.l10n.addresses, iconPath: 'assets/icons/location.svg', onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed(Routes.addressesView);
            }),
            ProfileItem(title: context.l10n.payment, iconPath: 'assets/icons/payment.svg', onTap: () {}),
          ]),

          const SizedBox(height: 16),

          _buildSectionContainer([
            ProfileItem(title: context.l10n.faq, iconPath: 'assets/icons/faq.svg', onTap: () {}),
            ProfileItem(title: context.l10n.privacyPolicy, iconPath: 'assets/icons/privacy.svg', onTap: () {}),
            ProfileItem(title: context.l10n.contactUs, iconPath: 'assets/icons/contact.svg', onTap: () {}),
            ProfileItem(title: context.l10n.complaints, iconPath: 'assets/icons/complaint.svg', onTap: () {}),
            ProfileItem(title: context.l10n.shareApp, iconPath: 'assets/icons/share.svg', onTap: () {}),
          ]),

          const SizedBox(height: 16),

          _buildSectionContainer([
            ProfileItem(
              title: context.l10n.logout,
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