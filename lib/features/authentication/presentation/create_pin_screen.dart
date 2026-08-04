import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';
import 'package:secret_contacts/features/authentication/presentation/widgets/pin_keypad.dart';

class CreatePinScreen extends StatefulWidget {
  const CreatePinScreen({super.key});

  @override
  State<CreatePinScreen> createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends State<CreatePinScreen> {
  String _pin = '';
  static const int _pinLength = 4;

  void _onDigitPressed(String digit) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += digit;
      });

      if (_pin.length == _pinLength) {
        // Navigate to confirm PIN and pass the current PIN
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            context.push('/confirm-pin', extra: _pin);
            // Reset for when we come back
            setState(() {
              _pin = '';
            });
          }
        });
      }
    }
  }

  void _onDeletePressed() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
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
            ).animate().fadeIn(duration: 500.ms).scale(),
            
            const SizedBox(height: AppTheme.spacingMd),
            
            Text(
              'Set your secure PIN',
              style: Theme.of(context).textTheme.headlineLarge,
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: AppTheme.spacingXs),
            
            Text(
              'Create a $_pinLength-digit code to protect your vault.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.onSurfaceVariant,
              ),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
            
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
                    color: isActive ? AppTheme.tertiary : Colors.transparent,
                    border: Border.all(
                      color: isActive ? AppTheme.tertiary : AppTheme.outline,
                      width: 2,
                    ),
                  ),
                );
              }),
            ).animate().fadeIn(delay: 400.ms),
            
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
    );
  }
}
