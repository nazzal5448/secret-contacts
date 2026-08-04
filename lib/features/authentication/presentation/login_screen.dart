import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';
import 'package:secret_contacts/features/authentication/data/auth_controller.dart';
import 'package:secret_contacts/core/services/providers.dart';
import 'package:secret_contacts/features/authentication/presentation/widgets/pin_keypad.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String _pin = '';
  static const int _pinLength = 4;
  bool _hasError = false;
  bool _canUseBiometrics = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    final authController = ref.read(authControllerProvider);
    final isEnabled = await ref.read(secureStorageServiceProvider).isBiometricsEnabled();
    final canUse = await authController.canUseBiometrics();
    
    if (mounted) {
      setState(() {
        _canUseBiometrics = isEnabled && canUse;
      });
      
      if (_canUseBiometrics) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _onBiometricPressed();
          }
        });
      }
    }
  }

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
    final authController = ref.read(authControllerProvider);
    final isValid = await authController.verifyPin(_pin);
    
    if (isValid) {
      if (mounted) {
        context.go('/home');
      }
    } else {
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

  Future<void> _onBiometricPressed() async {
    final authController = ref.read(authControllerProvider);
    final didAuthenticate = await authController.authenticateWithBiometrics();
    
    if (didAuthenticate && mounted) {
      context.go('/home');
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
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
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
              child: const Icon(Icons.lock, color: AppTheme.tertiary, size: 32),
            ),
            
            const SizedBox(height: AppTheme.spacingMd),
            
            Text(
              'Enter PIN',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            
            const SizedBox(height: AppTheme.spacingXs),
            
            Text(
              _hasError ? 'Incorrect PIN.' : 'Unlock your secure vault.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: _hasError ? AppTheme.error : AppTheme.onSurfaceVariant,
              ),
            ).animate(target: _hasError ? 1 : 0).shake(),
            
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
              showBiometric: _canUseBiometrics,
              onBiometricPressed: _onBiometricPressed,
            ),
            
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
