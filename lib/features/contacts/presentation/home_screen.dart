import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';
import 'package:secret_contacts/features/contacts/data/providers.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final contactsAsync = ref.watch(contactsProvider);

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
        backgroundColor: AppTheme.surface.withOpacity(0.8),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppTheme.onSurfaceVariant),
            onPressed: () {},
          ),
        ],
      ),
      body: contactsAsync.when(
        data: (contacts) {
          final totalContacts = contacts.length;
          final favoriteContacts = contacts.where((c) => c.isFavorite).length;

          return CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.all(AppTheme.spacingLg),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    // Greeting & Search
                    const SizedBox(height: AppTheme.spacingMd),
                    Text(
                      'Hello, User',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      'Your secure vault is active and encrypted.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppTheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingLg),

                    // Search Bar Placeholder
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: AppTheme.spacingMd),
                          const Icon(Icons.search, color: AppTheme.onSurfaceVariant),
                          const SizedBox(width: AppTheme.spacingMd),
                          Text(
                            'Search contacts...',
                            style: TextStyle(color: AppTheme.onSurfaceVariant.withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXl),

                    // Stats Bento Grid
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              title: 'Total Contacts',
                              value: totalContacts.toString(),
                              icon: Icons.group,
                              iconColor: AppTheme.tertiary,
                            ),
                          ),
                          const SizedBox(width: AppTheme.spacingMd),
                          Expanded(
                            child: _buildStatCard(
                              title: 'Favorites',
                              value: favoriteContacts.toString(),
                              icon: Icons.star,
                              iconColor: AppTheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingXl),

                    // Main Contact List
                    Text(
                      'All Contacts',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                  ]),
                ),
              ),
              
              if (contacts.isEmpty)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppTheme.spacingXl),
                      child: Text(
                        'No contacts found. Add one.',
                        style: TextStyle(color: AppTheme.onSurfaceVariant),
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingLg),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final contact = contacts[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceVariant.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppTheme.outline.withOpacity(0.1)),
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: AppTheme.primaryContainer,
                              child: Text(
                                contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?',
                                style: const TextStyle(color: AppTheme.onPrimaryContainer),
                              ),
                            ),
                            title: Text(contact.name),
                            subtitle: Text(contact.notes ?? 'Encrypted Channel'),
                            trailing: const Icon(Icons.chevron_right, color: AppTheme.onSurfaceVariant),
                            onTap: () {
                              context.push('/contact-details/${contact.id}');
                            },
                          ),
                        );
                      },
                      childCount: contacts.length,
                    ),
                  ),
                ),
                
              const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-contact');
        },
        backgroundColor: AppTheme.tertiary,
        foregroundColor: AppTheme.onTertiary,
        child: const Icon(Icons.add, size: 32),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: iconColor),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppTheme.onSurfaceVariant,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ],
          ),
        ],
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
        if (index == 2) {
          context.go('/settings');
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
