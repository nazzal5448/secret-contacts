import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';
import 'package:secret_contacts/features/authentication/data/auth_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Check if the user has a PIN setup
    final hasPin = await ref.read(authControllerProvider).hasPinSetup();
    
    // Simulate initial loading time for the splash screen
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      if (hasPin) {
        context.go('/login');
      } else {
        context.go('/onboarding');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Atmospheric Layer
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primary.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.05),
                    blurRadius: 120,
                    spreadRadius: 120,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.tertiary.withOpacity(0.05),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.tertiary.withOpacity(0.05),
                    blurRadius: 120,
                    spreadRadius: 120,
                  ),
                ],
              ),
            ),
          ),
          
          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Hero Visual: Shield Logo
                SizedBox(
                  width: 140,
                  height: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Glow
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.tertiary.withOpacity(0.2),
                        ),
                      )
                          .animate(onPlay: (controller) => controller.repeat())
                          .scale(begin: const Offset(1, 1), end: const Offset(1.5, 1.5), duration: 2.seconds, curve: Curves.easeInOut)
                          .fade(begin: 0.4, end: 0, duration: 2.seconds, curve: Curves.easeInOut),
                      
                      // Central Shield Icon
                      Container(
                        width: 128,
                        height: 128,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: AppTheme.onSurfaceVariant.withOpacity(0.2)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/icon.png',
                          width: 64,
                          height: 64,
                        ),
                      ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                          .moveY(begin: 0, end: -10, duration: 3.seconds, curve: Curves.easeInOut),
                      
                      // Small Lock Detail
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppTheme.primary,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.surface, width: 2),
                          ),
                          child: const Icon(
                            Icons.lock,
                            size: 20,
                            color: AppTheme.primaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack),
                
                const SizedBox(height: AppTheme.spacingXl),
                
                // Typography Branding
                Text(
                  'Secret Contacts',
                  style: Theme.of(context).textTheme.headlineLarge,
                ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
                
                const SizedBox(height: AppTheme.spacingXs),
                
                Text(
                  'Your private contacts, protected.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.onSurfaceVariant.withOpacity(0.8),
                  ),
                ).animate().fadeIn(delay: 500.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
              ],
            ),
          ),
          
          // Bottom Indicator Area
          Positioned(
            bottom: AppTheme.spacingXl,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Loading Progress Bar
                Container(
                  width: 192,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: AppTheme.onSurfaceVariant.withOpacity(0.1)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 60,
                            decoration: BoxDecoration(
                              color: AppTheme.tertiary,
                              borderRadius: BorderRadius.circular(3),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.tertiary.withOpacity(0.5),
                                  blurRadius: 8,
                                )
                              ],
                            ),
                          )
                              .animate(onPlay: (controller) => controller.repeat())
                              .moveX(begin: -60, end: 192, duration: 2.seconds, curve: Curves.easeInOut),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 800.ms),
                
                const SizedBox(height: AppTheme.spacingMd),
                
                // Security Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_user,
                      size: 14,
                      color: AppTheme.onSurfaceVariant.withOpacity(0.4),
                    ),
                    const SizedBox(width: AppTheme.spacingXs),
                    Text(
                      'AES-256 ENCRYPTED',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.onSurfaceVariant.withOpacity(0.4),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 1000.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
