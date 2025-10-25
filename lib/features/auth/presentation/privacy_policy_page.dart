import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
        title: const Text('Privacy Policy'),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
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
                'Welcome to Lang Learn (the "App"), developed and operated by Lang Learn (referred to as "we," "us," or "our"). This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application. By using the App, you consent to the practices described in this policy. If you do not agree, please do not use the App. We may update this Privacy Policy at any time, and we will notify you of material changes via the App or email.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '2. Information We Collect',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'We collect information to provide and improve our services. This includes:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '• Personal Data: Such as your name, email address, and password when you create an account or contact us.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Usage Data: Information on how you interact with the App, including lessons completed, progress metrics, and time spent on features.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Device Data: Technical details like device type, operating system, IP address, and unique device identifiers.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Location Data: If enabled, approximate location to personalize content (optional and with your consent).',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Other Data: Audio recordings for pronunciation practice (stored locally or anonymously if shared for improvement).',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '3. How We Collect Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                '• Directly from you: When you register, complete lessons, or provide feedback.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Automatically: Through device sensors and analytics tools as you use the App.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• From third parties: Such as authentication providers (e.g., Google, Apple) if you log in via those services.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '4. How We Use Your Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text('We use your data to:', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(
                '• Provide, maintain, and improve the App and its features.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Personalize your learning experience, such as tracking progress and suggesting lessons.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Communicate with you, including sending updates, notifications, and support responses.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Analyze usage patterns to enhance functionality and detect issues.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Comply with legal obligations and protect our rights.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '5. Sharing Your Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'We do not sell your personal data. We may share information with:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '• Service Providers: Third parties who assist with hosting, analytics, payments, or other operations (e.g., Google Analytics, Apple Pay). These providers are contractually obligated to protect your data.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Legal Requirements: If required by law, subpoena, or to protect safety and rights.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Business Transfers: In the event of a merger, acquisition, or asset sale.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '6. Data Security',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'We implement reasonable security measures, including encryption and access controls, to protect your data from unauthorized access, alteration, or destruction. However, no method is 100% secure, and we cannot guarantee absolute security.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '7. Your Rights and Choices',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'Depending on your location, you may have rights under privacy laws (e.g., GDPR, CCPA):',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                '• Access: Request a copy of your data.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Correction: Update inaccurate information.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Deletion: Request removal of your data, subject to legal exceptions.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Opt-Out: From targeted advertising or data sharing (if applicable).',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '• Withdraw Consent: Where processing is based on consent.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'To exercise these rights, contact us at timurkarev@gmail.com. We may verify your identity before responding.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '8. Data Retention',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'We retain your data as long as necessary for the purposes outlined in this policy or as required by law. When no longer needed, we securely delete or anonymize it.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '9. International Data Transfers',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'Your data may be transferred to and processed in countries outside your own, including the United States. We ensure appropriate safeguards, such as standard contractual clauses, are in place.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '10. Cookies and Similar Technologies',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'The App may use cookies, local storage, or similar technologies for functionality and analytics. You can manage preferences in your device settings.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '11. Children\'s Privacy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'The App is not intended for children under 13. We do not knowingly collect data from children under 13. If we become aware of such data, we will delete it. Parents/guardians should contact us with concerns.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '12. Third-Party Links',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'The App may contain links to third-party sites or services. We are not responsible for their privacy practices. Review their policies before providing information.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '13. Changes to This Privacy Policy',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'We may update this Privacy Policy periodically. Changes will be posted in the App with the updated date. Continued use constitutes acceptance.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                '14. Contact Us',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                'If you have questions about this Privacy Policy or our data practices, contact us at timurkarev@gmail.com.',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
