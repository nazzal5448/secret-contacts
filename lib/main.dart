import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:secret_contacts/core/config/router.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';
import 'package:secret_contacts/core/widgets/lifecycle_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  runApp(
    const ProviderScope(
      child: SecretContactsApp(),
    ),
  );
}

class SecretContactsApp extends StatelessWidget {
  const SecretContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LifecycleManager(
      child: MaterialApp.router(
        title: 'Secret Contacts',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark, // Default to dark for the premium feel
        darkTheme: AppTheme.darkTheme,
        routerConfig: router,
      ),
    );
  }
}
