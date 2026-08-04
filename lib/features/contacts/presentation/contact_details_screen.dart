import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';
import 'package:secret_contacts/features/contacts/data/providers.dart';
import 'package:secret_contacts/features/contacts/domain/contact.dart';

class ContactDetailsScreen extends ConsumerWidget {
  final String contactId;

  const ContactDetailsScreen({
    super.key,
    required this.contactId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(contactsProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: AppTheme.primary),
            onPressed: () {},
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: contactsAsync.when(
        data: (contacts) {
          final contact = contacts.firstWhere(
            (c) => c.id == contactId,
            orElse: () => Contact(
              id: '',
              name: 'Not Found',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );

          if (contact.id.isEmpty) {
            return const Center(child: Text('Contact not found'));
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildHeroSection(context, contact),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppTheme.spacingLg),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildQuickActions(),
                    const SizedBox(height: AppTheme.spacingXl),
                    
                    if (contact.phoneNumbers.isNotEmpty)
                      _buildDetailCard(
                        icon: Icons.smartphone,
                        label: 'Mobile',
                        value: contact.phoneNumbers.first,
                      ),
                    
                    if (contact.emails.isNotEmpty)
                      _buildDetailCard(
                        icon: Icons.alternate_email,
                        label: 'Email',
                        value: contact.emails.first,
                      ),
                    
                    if (contact.notes != null && contact.notes!.isNotEmpty)
                      _buildNotesCard(contact.notes!),
                      
                    const SizedBox(height: AppTheme.spacingXl),
                    
                    // Management Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.edit,
                            label: 'Edit',
                            color: AppTheme.onSurface,
                            onPressed: () {
                              context.push('/add-contact', extra: contact);
                            },
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacingMd),
                        Expanded(
                          child: _buildActionButton(
                            icon: Icons.delete,
                            label: 'Delete',
                            color: AppTheme.error,
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  backgroundColor: AppTheme.surfaceContainerHigh,
                                  title: const Text('Delete Contact?'),
                                  content: const Text('This action cannot be undone.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx, false),
                                      child: const Text('CANCEL'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(ctx, true),
                                      style: TextButton.styleFrom(foregroundColor: AppTheme.error),
                                      child: const Text('DELETE'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                final repo = ref.read(contactsRepositoryProvider);
                                await repo.deleteContact(contact.id);
                                ref.invalidate(contactsProvider);
                                if (context.mounted) {
                                  context.pop();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ]),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, Contact contact) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerHighest,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppTheme.surface,
                ],
              ),
            ),
          ),
          
          Positioned(
            bottom: AppTheme.spacingLg,
            left: AppTheme.spacingLg,
            right: AppTheme.spacingLg,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.verified, color: AppTheme.tertiary, size: 16),
                          const SizedBox(width: AppTheme.spacingXs),
                          Text(
                            'SECURE ENTRY',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppTheme.tertiary,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingXs),
                      Text(
                        contact.name,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          fontSize: 36,
                          color: AppTheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerHighest,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          contact.isFavorite ? Icons.star : Icons.star_border,
                          color: AppTheme.primary,
                          size: 28,
                        ),
                        onPressed: () async {
                          final updatedContact = contact.copyWith(isFavorite: !contact.isFavorite);
                          final repo = ref.read(contactsRepositoryProvider);
                          await repo.updateContact(updatedContact);
                          ref.invalidate(contactsProvider);
                        },
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(child: _buildQuickActionButton(icon: Icons.call, label: 'Call')),
        const SizedBox(width: AppTheme.spacingSm),
        Expanded(child: _buildQuickActionButton(icon: Icons.chat, label: 'Message')),
        const SizedBox(width: AppTheme.spacingSm),
        Expanded(child: _buildQuickActionButton(icon: Icons.videocam, label: 'Video')),
        const SizedBox(width: AppTheme.spacingSm),
        Expanded(child: _buildQuickActionButton(icon: Icons.mail, label: 'Email')),
      ],
    );
  }

  Widget _buildQuickActionButton({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppTheme.spacingSm),
            decoration: const BoxDecoration(
              color: AppTheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primary, size: 20),
          ),
          const SizedBox(height: AppTheme.spacingXs),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({required IconData icon, required String label, required String value}) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.outline.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppTheme.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppTheme.primary),
          ),
          const SizedBox(width: AppTheme.spacingMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppTheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.content_copy, color: AppTheme.outline),
            onPressed: () {}, // TODO: copy to clipboard
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(String notes) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: AppTheme.surfaceVariant.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.outline.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppTheme.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.notes, color: AppTheme.primary),
              ),
              const SizedBox(width: AppTheme.spacingMd),
              const Text(
                'Notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingMd),
          Text(
            notes,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color.withOpacity(0.3)),
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      icon: Icon(icon),
      label: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
