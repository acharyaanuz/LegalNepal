import 'package:flutter/material.dart';
import '../theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _pageIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Find the Right Lawyer',
      'desc': 'Discover lawyers based on your legal needs.',
    },
    {
      'title': 'Understand Your Rights',
      'desc': 'Explore basic legal information and procedures.',
    },
    {
      'title': 'Get Legal Consultation',
      'desc': 'Submit consultation requests conveniently.',
    },
  ];

  void _next() {
    if (_pageIndex < _slides.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _slides.length,
                onPageChanged: (index) => setState(() => _pageIndex = index),
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Placeholder illustration
                        Icon(Icons.account_balance, size: 120, color: AppColors.primary),
                        const SizedBox(height: 30),
                        Text(slide['title']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark), textAlign: TextAlign.center),
                        const SizedBox(height: 12),
                        Text(slide['desc']!, style: const TextStyle(fontSize: 16, color: AppColors.textDark), textAlign: TextAlign.center),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (i) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _pageIndex == i ? 12 : 8,
                height: _pageIndex == i ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _pageIndex == i ? AppColors.primary : Colors.grey,
                ),
              )),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: _skip, child: const Text('Skip')),
                  ElevatedButton(onPressed: _next, child: Text(_pageIndex == _slides.length - 1 ? 'Get Started' : 'Next')),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
