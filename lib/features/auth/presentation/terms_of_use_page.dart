import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lang_learn_mobile/l10n/app_localizations.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/login'),
        ),
        title: Text(AppLocalizations.of(context)!.termsOfUse),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms of Use',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                'Last updated: October 25, 2025',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 24),
              Text(
                '1. Introduction',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'Welcome to Lang Learn (the "App"), developed and operated by Lang Learn (referred to as "we," "us," or "our"). By downloading, installing, or using the App, you agree to comply with and be bound by these Terms and Conditions (the "Terms"). If you do not agree, do not use the App. These Terms constitute a legally binding agreement between you and Lang Learn regarding your use of the App. The App is intended for language learning. You must be at least 13 years old to use the App. By accessing or using the App, you represent that you meet this age requirement and have the legal capacity to enter into these Terms.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '2. Definitions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                '- "App" – Refers to Lang Learn, including all associated software, content, features, and updates.\n- "User" – Any individual who accesses or uses the App.\n- "Content" – All text, graphics, images, audio, video, data, and other materials available through the App.\n- "Service" – The language learning features, lessons, exercises, and any related services provided via the App.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '3. License to Use',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'We grant you a limited, non-exclusive, non-transferable, revocable license to access and use the App for personal, non-commercial purposes in accordance with these Terms. This license does not allow you to:\n- Copy, modify, distribute, sell, or lease any part of the App or its Content.\n- Reverse engineer, decompile, or attempt to derive the source code of the App.\n- Remove or alter any copyright, trademark, or other proprietary notices.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '4. Acceptable Use',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'You agree to use the App only for lawful purposes and in a way that does not infringe on the rights of others. Acceptable uses include:\n- Engaging with language learning features, such as lessons, quizzes, and progress tracking.\n- Providing feedback to improve the App.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '5. Prohibited Behaviors',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'You agree not to:\n- Use the App to violate any law or third-party rights.\n- Interfere with or disrupt the App’s functionality.\n- Attempt to gain unauthorized access to the App or its systems.\n- Use the App to transmit spam, malware, or harmful code.\n- Impersonate any person or entity or misrepresent your affiliation.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '6. User Accounts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'Some features require an account.\n- You are responsible for maintaining the confidentiality of your account credentials.\n- You must provide accurate information and update it as needed.\n- You agree to notify us immediately of any unauthorized access to your account.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '7. Intellectual Property',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'The App, including its Content, design, and software, is owned by Lang Learn or its licensors and is protected by copyright, trademark, and other laws. You may not reproduce, distribute, or create derivative works from any Content without our written permission.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '8. User-Generated Content',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'Users can submit voice recordings or text responses for practice.\n- You retain ownership of your Content but grant us a worldwide, royalty-free, perpetual license to use, modify, and display it within the App.\n- We may remove any Content that violates these Terms.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '9. Payments and Subscriptions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'If the App offers paid features or subscriptions:\n- Fees are charged as described during signup or purchase.\n- Subscriptions auto-renew unless canceled at least 24 hours before the renewal date.\n- All payments are processed through third-party providers and are non-refundable except as required by law.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '10. Privacy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'Your privacy is important to us. Our Privacy Policy explains how we collect, use, and disclose your information. By using the App, you consent to our data practices.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '11. Limitation of Liability',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'To the fullest extent permitted by law, Lang Learn is not liable for any indirect, incidental, special, consequential, or punitive damages arising from your use of the App, even if advised of the possibility of such damages.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '12. Disclaimers and Warranties',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'The App is provided "as is" and "as available" without warranties of any kind, express or implied, including but not limited to warranties of merchantability, fitness for a particular purpose, or non-infringement. We do not guarantee that the App will be error-free, secure, or available at all times. Lesson content is for educational purposes only and may not be 100% accurate; users should verify information independently.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '13. Termination',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'We may suspend or terminate your access to the App at our discretion, without notice, if you violate these Terms. You may stop using the App at any time. Upon termination, your user data may be retained for a reasonable period as per our Privacy Policy.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '14. Changes to Terms',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'We may update these Terms at any time. We will notify you of material changes via the App or email. Your continued use after changes constitutes acceptance.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '15. Governing Law',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'These Terms are governed by the laws of the State of California, without regard to conflict of law principles. Any disputes will be resolved in the courts of California.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '16. Contact Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'If you have questions about these Terms, contact us at: timurkarev@gmail.com',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
