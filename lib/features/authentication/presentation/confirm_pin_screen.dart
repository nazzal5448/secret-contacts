import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';
import 'package:secret_contacts/features/authentication/data/auth_controller.dart';
import 'package:secret_contacts/features/authentication/presentation/widgets/pin_keypad.dart';

class ConfirmPinScreen extends ConsumerStatefulWidget {
  final String originalPin;
  const ConfirmPinScreen({super.key, required this.originalPin});

  @override
  ConsumerState<ConfirmPinScreen> createState() => _ConfirmPinScreenState();
}

class _ConfirmPinScreenState extends ConsumerState<ConfirmPinScreen> {
  String _pin = '';
  static const int _pinLength = 4;
  bool _hasError = false;
  bool _showSuccessModal = false;

  void _onDigitPressed(String digit) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += digit;
        _hasError = false;
      });

      if (_pin.length == _pinLength) {
        _validatePin();
      }
    }
  }

  void _onDeletePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _hasError = false;
      });
    }
  }

  Future<void> _validatePin() async {
    if (_pin == widget.originalPin) {
      // Success!
      final authController = ref.read(authControllerProvider);
      await authController.setupPin(_pin);
      
      // Check biometrics availability
      final canBiometrics = await authController.canUseBiometrics();
      if (canBiometrics) {
        await authController.setBiometricsEnabled(true); // default to true if supported during setup, or we could ask.
      }
      
      setState(() {
        _showSuccessModal = true;
      });
    } else {
      // Error: mismatch
      setState(() {
        _hasError = true;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _pin = '';
            _hasError = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.shield, color: AppTheme.primary),
            const SizedBox(width: AppTheme.spacingXs),
            Text(
              'Secret Contacts',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: AppTheme.onSurfaceVariant),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 1),
                
                // Header Info
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceVariant,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.onSurfaceVariant.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.lock_reset, color: AppTheme.tertiary, size: 32),
                ).animate().fadeIn(duration: 500.ms).scale(),
                
                const SizedBox(height: AppTheme.spacingMd),
                
                Text(
                  'Confirm your PIN',
                  style: Theme.of(context).textTheme.headlineLarge,
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                
                const SizedBox(height: AppTheme.spacingXs),
                
                Text(
                  _hasError ? 'PINs do not match. Try again.' : 'Re-enter your code to confirm.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: _hasError ? AppTheme.error : AppTheme.onSurfaceVariant,
                  ),
                ).animate(target: _hasError ? 1 : 0).shake(), // simple shake effect on error
                
                const SizedBox(height: AppTheme.spacingXl),
                
                // PIN Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_pinLength, (index) {
                    final isActive = index < _pin.length;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingSm),
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive 
                            ? (_hasError ? AppTheme.error : AppTheme.tertiary) 
                            : Colors.transparent,
                        border: Border.all(
                          color: isActive 
                              ? (_hasError ? AppTheme.error : AppTheme.tertiary) 
                              : AppTheme.outline,
                          width: 2,
                        ),
                      ),
                    );
                  }),
                )
                .animate(target: _hasError ? 1 : 0)
                .shake(hz: 8, curve: Curves.easeInOutCubic, duration: 400.ms),
                
                const Spacer(flex: 2),
                
                // Keypad Grid
                PinKeypad(
                  onDigitPressed: _onDigitPressed,
                  onDeletePressed: _onDeletePressed,
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
                
                const Spacer(flex: 1),
              ],
            ),
          ),
          
          if (_showSuccessModal)
            Positioned.fill(
              child: Container(
                color: AppTheme.surface.withOpacity(0.9),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
                    padding: const EdgeInsets.all(AppTheme.spacingXl),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceVariant.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: AppTheme.onSurfaceVariant.withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 40,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppTheme.tertiary.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check_circle,
                            color: AppTheme.tertiary,
                            size: 48,
                          ),
                        ).animate().scale(curve: Curves.easeOutBack, duration: 600.ms),
                        
                        const SizedBox(height: AppTheme.spacingLg),
                        
                        Text(
                          'PIN Secured',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        
                        const SizedBox(height: AppTheme.spacingSm),
                        
                        Text(
                          'Your identity is now protected with military-grade encryption.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.onSurfaceVariant,
                          ),
                        ),
                        
                        const SizedBox(height: AppTheme.spacingXl),
                        
                        ElevatedButton(
                          onPressed: () => context.go('/home'),
                          child: const Text('Enter Vault'),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.9, 0.9)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
