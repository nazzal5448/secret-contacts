import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';
import 'package:secret_contacts/features/authentication/data/auth_controller.dart';
import 'package:secret_contacts/core/services/providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _biometricsEnabled = false;
  bool _isSupported = false;
  int _currentIndex = 2; // Settings is index 2

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final authController = ref.read(authControllerProvider);
    final secureStorage = ref.read(secureStorageServiceProvider);
    
    final isSupported = await authController.canUseBiometrics();
    final enabled = await secureStorage.isBiometricsEnabled();
    
    if (mounted) {
      setState(() {
        _isSupported = isSupported;
        _biometricsEnabled = enabled && isSupported;
      });
    }
  }

  Future<void> _toggleBiometrics(bool value) async {
    final authController = ref.read(authControllerProvider);
    await authController.setBiometricsEnabled(value);
    setState(() {
      _biometricsEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.settings, color: AppTheme.primary),
            const SizedBox(width: AppTheme.spacingXs),
            Text(
              'Settings',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        backgroundColor: AppTheme.surface.withOpacity(0.8),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppTheme.spacingLg),
        children: [
          _buildSectionHeader('Security'),
          
          if (_isSupported)
            _buildSettingsTile(
              title: 'Biometric Unlock',
              subtitle: 'Use fingerprint or face to unlock',
              icon: Icons.fingerprint,
              trailing: Switch(
                value: _biometricsEnabled,
                onChanged: _toggleBiometrics,
                activeColor: AppTheme.tertiary,
              ),
            ),
            
          _buildSettingsTile(
            title: 'Change PIN',
            subtitle: 'Update your master PIN',
            icon: Icons.password,
            onTap: () {
              // Note: Would need a flow to verify current PIN, then create new one.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change PIN flow coming soon.')),
              );
            },
          ),
          
          const SizedBox(height: AppTheme.spacingXl),
          _buildSectionHeader('Data & Storage'),
          
          _buildSettingsTile(
            title: 'Export Contacts',
            subtitle: 'Export encrypted backup',
            icon: Icons.upload_file,
            onTap: () {},
          ),
          
          _buildSettingsTile(
            title: 'Delete All Data',
            subtitle: 'Permanently destroy your vault',
            icon: Icons.delete_forever,
            iconColor: AppTheme.error,
            onTap: () {},
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppTheme.primary,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required String title,
    required String subtitle,
    required IconData icon,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant.withOpacity(0.6),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outline.withOpacity(0.1)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor ?? AppTheme.onSurfaceVariant),
        ),
        title: Text(title, style: const TextStyle(color: AppTheme.onSurface)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12)),
        trailing: trailing ?? (onTap != null ? const Icon(Icons.chevron_right, color: AppTheme.onSurfaceVariant) : null),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.surface.withOpacity(0.9),
        border: Border(
          top: BorderSide(color: AppTheme.outline.withOpacity(0.1)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.contacts, 'Contacts'),
          _buildNavItem(1, Icons.star, 'Favorites'),
          _buildNavItem(2, Icons.settings, 'Settings'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          context.go('/home');
        } else {
          setState(() {
            _currentIndex = index;
          });
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? AppTheme.secondaryContainer : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              icon,
              color: isActive ? AppTheme.onSecondaryContainer : AppTheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isActive ? AppTheme.onSurface : AppTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
