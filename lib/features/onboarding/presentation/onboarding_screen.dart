import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;
  int totalPages = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 124),
            Icon(
              Icons.home,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            Text(
              'Киригиз тили',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
        ),
        actionsPadding: EdgeInsets.only(right: 16),
        actions: [
          TextButton(
            onPressed: () {
              context.go('/home');
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.tertiary,
            ),
            child: Text('Skip'),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: totalPages,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) => FlutterLogo(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/home');
              },
              child: Text(currentIndex < totalPages - 1 ? 'Next' : 'Finish'),
            ),
            // Dot indicators
          ],
        ),
      ),
    );
  }
}
