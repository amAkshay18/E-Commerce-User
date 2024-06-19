import 'package:flutter/material.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';
import 'package:leafloom/view/settings/about_us/about_us.dart';
import 'package:leafloom/view/settings/privacy_policy/privacy_policy.dart';
import 'package:leafloom/view/settings/terms_and_conditions/terms_and_conditions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const CustomTextWidget(
          'Settings',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _buildSettingsTile(
                  title: 'Privacy Policy',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen(),
                      ),
                    );
                  },
                ),
                const Divider(),
                _buildSettingsTile(
                  title: 'Terms and Conditions',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsAndConditionsScreen(),
                      ),
                    );
                  },
                ),
                const Divider(),
                _buildSettingsTile(
                  title: 'About Us',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutUsScreen(),
                      ),
                    );
                  },
                ),
                const Divider(),
              ],
            ),
          ),
          const Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: CustomTextWidget(
                'Version: 1.1.1',
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
      {required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: CustomTextWidget(
          title,
          fontSize: 18,
        ),
      ),
    );
  }
}




// class SettingsBody extends StatelessWidget {
//   const SettingsBody({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: SizedBox(
//         width: double.infinity,
//         child: Column(
//           children: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 28.0),
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(8),
//                     ),
//                   ),
//                   height: 340,
//                   width: 350,
//                   child: Column(
//                     children: [
//                       AccountTile(
//                         icon: Icons.privacy_tip,
//                         name: 'Privacy and Policy',
//                         voidCallback: () {
//                           context
//                               .read<PrivacyPolicyProvider>()
//                               .privacyPolicyMethod(context);
//                         },
//                       ),
//                       AccountTile(
//                         icon: Icons.file_copy,
//                         name: 'Terms and Conditions',
//                         voidCallback: () {
//                           context
//                               .read<TermsAndConditonsProvider>()
//                               .termsAndConditionsMethod(context);
//                         },
//                       ),
//                       AccountTile(
//                         icon: CupertinoIcons.info_circle_fill,
//                         name: 'About Us',
//                         voidCallback: () {
//                           context
//                               .read<AboutUsProvider>()
//                               .aboutUsMethod(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             const CustomTextWidget(
//               'version 1.1.0',
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
