import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafloom/shared/core/utils/text_widget.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          'About Us',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome to LeafLoom - Your Green Haven!',
                style: GoogleFonts.openSans(),
              ),
              const SizedBox(height: 16),
              const CustomTextWidget(
                'About LeafLoom:',
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 8),
              Text(
                'LeafLoom is your one-stop destination for all things green! We specialize in providing a wide variety of indoor and outdoor plants to bring nature into your home and garden. Our passion for plants and commitment to quality make us your trusted partner in creating a lush, green environment.',
                style: GoogleFonts.openSans(),
              ),
              const SizedBox(height: 16),
              const CustomTextWidget(
                'Our Mission:',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Text(
                'At LeafLoom, our mission is to inspire and enable people to embrace the beauty of nature. We strive to offer a curated selection of high-quality plants, along with a seamless shopping experience. Whether you are a seasoned plant enthusiast or just starting your green journey, LeafLoom is here to cater to your plant needs.',
                style: GoogleFonts.openSans(),
              ),
              const SizedBox(height: 16),
              const CustomTextWidget(
                'Why Choose LeafLoom?',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              const SizedBox(height: 8),
              Text(
                '1. Wide Variety: Explore a diverse range of indoor and outdoor plants to suit your preferences and space.',
                style: GoogleFonts.openSans(),
              ),
              Text(
                '2. Quality Assurance: Each plant is carefully selected and nurtured to ensure it meets our high-quality standards.',
                style: GoogleFonts.openSans(),
              ),
              Text(
                '3. Secure Payments: Shop with confidence using our secure payment gateway powered by Razorpay.',
                style: GoogleFonts.openSans(),
              ),
              Text(
                '4. Convenient Delivery: Provide us with your address, and we will ensure timely delivery of your green companions.',
                style: GoogleFonts.openSans(),
              ),
              const SizedBox(height: 16),
              Text(
                'Thank you for choosing LeafLoom for all your plant needs!',
                style: GoogleFonts.openSans(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
