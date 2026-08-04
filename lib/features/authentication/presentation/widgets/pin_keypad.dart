import 'package:flutter/material.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';

class PinKeypad extends StatelessWidget {
  final Function(String) onDigitPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback? onBiometricPressed;
  final bool showBiometric;

  const PinKeypad({
    super.key,
    required this.onDigitPressed,
    required this.onDeletePressed,
    this.onBiometricPressed,
    this.showBiometric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: AppTheme.spacingMd,
        crossAxisSpacing: AppTheme.spacingMd,
        childAspectRatio: 1.2,
        children: [
          _buildNumberButton('1'),
          _buildNumberButton('2'),
          _buildNumberButton('3'),
          _buildNumberButton('4'),
          _buildNumberButton('5'),
          _buildNumberButton('6'),
          _buildNumberButton('7'),
          _buildNumberButton('8'),
          _buildNumberButton('9'),
          _buildBiometricButton(),
          _buildNumberButton('0'),
          _buildDeleteButton(),
        ],
      ),
    );
  }

  Widget _buildNumberButton(String digit) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onDigitPressed(digit),
        borderRadius: BorderRadius.circular(40),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceVariant,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: AppTheme.onSurfaceVariant.withOpacity(0.1)),
          ),
          alignment: Alignment.center,
          child: Text(
            digit,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: AppTheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onDeletePressed,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          alignment: Alignment.center,
          child: const Icon(
            Icons.backspace_outlined,
            size: 28,
            color: AppTheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildBiometricButton() {
    if (!showBiometric) return const SizedBox.shrink();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onBiometricPressed,
        borderRadius: BorderRadius.circular(40),
        child: Container(
          alignment: Alignment.center,
          child: const Icon(
            Icons.fingerprint,
            size: 32,
            color: AppTheme.tertiary,
          ),
        ),
      ),
    );
  }
}
