import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';
import 'package:secret_contacts/core/widgets/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  void _onNext() {
    // Navigate to create PIN screen
    context.go('/create-pin');
  }

  void _onSkip() {
    // Navigate to create PIN screen directly
    context.go('/create-pin');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Glow Mesh
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primary.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.05),
                    blurRadius: 100,
                    spreadRadius: 80,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.2,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.tertiary.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.tertiary.withOpacity(0.05),
                    blurRadius: 100,
                    spreadRadius: 80,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top AppBar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingLg,
                    vertical: AppTheme.spacingMd,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.shield, color: AppTheme.primary),
                          const SizedBox(width: AppTheme.spacingXs),
                          Text(
                            'Secret Contacts',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.2, end: 0),
                      TextButton(
                        onPressed: _onSkip,
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.onSurfaceVariant,
                        ),
                        child: const Text('Skip'),
                      ).animate().fadeIn(duration: 500.ms).slideX(begin: 0.2, end: 0),
                    ],
                  ),
                ),

                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Illustration Area
                            SizedBox(
                              height: 300,
                              width: 300,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Premium Privacy Illustration Glass Card
                                  Container(
                                    width: 220,
                                    height: 220,
                                    decoration: BoxDecoration(
                                      color: AppTheme.surfaceVariant.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(48),
                                      border: Border.all(
                                        color: AppTheme.onSurface.withOpacity(0.05),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 30,
                                          offset: const Offset(0, 15),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(AppTheme.spacingXl),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(height: 12, width: 120, decoration: BoxDecoration(color: AppTheme.onSurfaceVariant.withOpacity(0.2), borderRadius: BorderRadius.circular(6))),
                                          const SizedBox(height: AppTheme.spacingMd),
                                          Container(height: 12, width: 80, decoration: BoxDecoration(color: AppTheme.onSurfaceVariant.withOpacity(0.2), borderRadius: BorderRadius.circular(6))),
                                          const SizedBox(height: AppTheme.spacingMd),
                                          Container(height: 12, width: 100, decoration: BoxDecoration(color: AppTheme.onSurfaceVariant.withOpacity(0.2), borderRadius: BorderRadius.circular(6))),
                                        ],
                                      ),
                                    ),
                                  ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                                      .moveY(begin: 0, end: -15, duration: 4.seconds, curve: Curves.easeInOut),
                                  
                                  // Top Right Lock Accent
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Transform.rotate(
                                      angle: 0.2,
                                      child: Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          color: AppTheme.tertiary,
                                          borderRadius: BorderRadius.circular(24),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppTheme.tertiary.withOpacity(0.3),
                                              blurRadius: 15,
                                              offset: const Offset(0, 8),
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.lock,
                                          color: AppTheme.tertiaryContainer,
                                          size: 32,
                                        ),
                                      ),
                                    ),
                                  ).animate().fadeIn(delay: 400.ms).scale(begin: const Offset(0.5, 0.5), curve: Curves.easeOutBack),
                                  
                                  // Bottom Left Accent
                                  Positioned(
                                    bottom: 30,
                                    left: -10,
                                    child: Transform.rotate(
                                      angle: -0.1,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: AppTheme.surfaceVariant.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(
                                            color: AppTheme.onSurface.withOpacity(0.05),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.fingerprint,
                                          color: AppTheme.primary,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.5, 0.5), curve: Curves.easeOutBack),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: AppTheme.spacingXl),
                            
                            // Content Area
                            Text(
                              'Keep personal contacts private.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                            
                            const SizedBox(height: AppTheme.spacingMd),
                            
                            Text(
                              'Your high-security vault for sensitive connections. Encrypted, hidden, and only accessible by you.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: AppTheme.onSurfaceVariant.withOpacity(0.8),
                              ),
                            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom Action Bar
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingLg),
                  decoration: BoxDecoration(
                    color: AppTheme.surface.withOpacity(0.8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Progress Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 32, height: 6, decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(3))),
                          const SizedBox(width: AppTheme.spacingBase),
                          Container(width: 8, height: 6, decoration: BoxDecoration(color: AppTheme.surfaceVariant, borderRadius: BorderRadius.circular(3))),
                          const SizedBox(width: AppTheme.spacingBase),
                          Container(width: 8, height: 6, decoration: BoxDecoration(color: AppTheme.surfaceVariant, borderRadius: BorderRadius.circular(3))),
                        ],
                      ).animate().fadeIn(delay: 600.ms),
                      
                      const SizedBox(height: AppTheme.spacingLg),
                      
                      PrimaryButton(
                        text: 'Next',
                        icon: Icons.arrow_forward,
                        onPressed: _onNext,
                      ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2, end: 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
