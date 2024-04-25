import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const CustomTextWidget(
          'Privacy Policy',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextWidget(
              'Last Updated: 26-01-2024',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 5.0),
            Text(
              'Thank you for using the LeafLoom Ecommerce App. This Privacy Policy outlines how we collect, use, and safeguard your personal information. By using our app, you consent to the terms described in this policy.',
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 10.0),
            const CustomTextWidget(
              'Information We Collect',
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 5.0),
            const CustomTextWidget(
              'Personal Information:',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            const SizedBox(height: 5.0),
            Text(
              '1. ID: A unique identifier assigned to your account.',
              style: GoogleFonts.openSans(),
            ),
            Text(
              '2. Full Name: Your full name for order processing and personalized communication.',
              style: GoogleFonts.openSans(),
            ),
            Text(
              '3. Pincode, City, and State: Required for accurate delivery of your purchased items.',
              style: GoogleFonts.openSans(),
            ),
            Text(
              '4. Phone Number: Used for communication regarding your orders and services.',
              style: GoogleFonts.openSans(),
            ),
            Text(
              '5. House and Area Information: Specific address details for precise delivery.',
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 10.0),
            const CustomTextWidget(
              'Payment Information',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            const SizedBox(height: 5.0),
            Text(
              'We use Razorpay, a secure payment gateway, to process payments. We do not store your payment information on our servers. Please refer to Razorpay\'s privacy policy for details on how they handle your payment information.',
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Usage Information',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5.0),
            Text(
              'We may collect information about how you interact with our app, such as pages visited, products viewed, and actions taken.',
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 15.0),
            const CustomTextWidget(
              'How We Use Your Information',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            const SizedBox(height: 10.0),
            Text(
              '1. Order Fulfillment: To process and deliver your orders accurately.',
              style: GoogleFonts.openSans(),
            ),
            Text(
              '2. Communication: Sending order updates, promotions, and important notifications.',
              style: GoogleFonts.openSans(),
            ),
            Text(
              '3. Improving our Services: Analyzing user behavior to enhance the app\'s functionality and user experience.',
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 15.0),
            const CustomTextWidget(
              'Information Sharing',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            const SizedBox(height: 5.0),
            Text(
              'We do not sell, trade, or otherwise transfer your personal information to third parties unless we provide you with advance notice or as required by law.',
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 15.0),
            const CustomTextWidget(
              'Security',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            const SizedBox(height: 5.0),
            Text(
              'We implement a variety of security measures to protect the safety of your personal information.',
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 15.0),
            const CustomTextWidget(
              'Your Choices',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            const SizedBox(height: 5.0),
            Text(
              'You can review and update your account information through the app. You may also opt-out of receiving promotional communications.',
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 15.0),
            const CustomTextWidget(
              'Changes to this Privacy Policy',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            const SizedBox(height: 5.0),
            Text(
              'We reserve the right to modify this privacy policy at any time. Please review it frequently. Changes and clarifications will take effect immediately upon their posting on the app.',
              style: GoogleFonts.openSans(),
            ),
            const SizedBox(height: 15.0),
            const CustomTextWidget(
              'Contact Us',
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            const SizedBox(height: 5.0),
            Text(
              'If you have any questions about this Privacy Policy, please contact us at thisisakshayp18@gmail.com.',
              style: GoogleFonts.openSans(),
            ),
          ],
        ),
      ),
    );
  }
}
