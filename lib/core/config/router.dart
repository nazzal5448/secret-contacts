import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_contacts/features/authentication/presentation/splash_screen.dart';
import 'package:secret_contacts/features/onboarding/presentation/onboarding_screen.dart';
import 'package:secret_contacts/features/authentication/presentation/create_pin_screen.dart';
import 'package:secret_contacts/features/authentication/presentation/confirm_pin_screen.dart';
import 'package:secret_contacts/features/authentication/presentation/login_screen.dart';
import 'package:secret_contacts/features/contacts/presentation/home_screen.dart';
import 'package:secret_contacts/features/contacts/presentation/add_contact_screen.dart';
import 'package:secret_contacts/features/contacts/presentation/contact_details_screen.dart';
import 'package:secret_contacts/features/settings/presentation/settings_screen.dart';
import 'package:secret_contacts/features/contacts/domain/contact.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/create-pin',
      builder: (context, state) => const CreatePinScreen(),
    ),
    GoRoute(
      path: '/confirm-pin',
      builder: (context, state) {
        final pin = state.extra as String;
        return ConfirmPinScreen(originalPin: pin);
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/add-contact',
      builder: (context, state) {
        final contact = state.extra as Contact?;
        return AddContactScreen(contactToEdit: contact);
      },
    ),
    GoRoute(
      path: '/contact-details/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ContactDetailsScreen(contactId: id);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
