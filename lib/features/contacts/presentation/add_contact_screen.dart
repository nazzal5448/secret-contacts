import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_contacts/core/theme/app_theme.dart';
import 'package:secret_contacts/core/widgets/primary_button.dart';
import 'package:secret_contacts/features/contacts/data/providers.dart';
import 'package:secret_contacts/features/contacts/domain/contact.dart';

class AddContactScreen extends ConsumerStatefulWidget {
  final Contact? contactToEdit;

  const AddContactScreen({
    super.key,
    this.contactToEdit,
  });

  @override
  ConsumerState<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends ConsumerState<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    if (widget.contactToEdit != null) {
      final c = widget.contactToEdit!;
      final nameParts = c.name.split(' ');
      _firstNameController.text = nameParts.first;
      if (nameParts.length > 1) {
        _lastNameController.text = nameParts.sublist(1).join(' ');
      }
      if (c.phoneNumbers.isNotEmpty) {
        _phoneController.text = c.phoneNumbers.first;
      }
      if (c.emails.isNotEmpty) {
        _emailController.text = c.emails.first;
      }
      if (c.notes != null) {
        _notesController.text = c.notes!;
      }
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _saveContact() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSaving = true;
      });

      final repo = ref.read(contactsRepositoryProvider);
      
      if (widget.contactToEdit != null) {
        final updatedContact = widget.contactToEdit!.copyWith(
          name: '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}'.trim(),
          phoneNumbers: [_phoneController.text.trim()],
          emails: [_emailController.text.trim()],
          notes: _notesController.text.trim(),
          updatedAt: DateTime.now(),
        );
        await repo.updateContact(updatedContact);
      } else {
        final newContact = Contact(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}'.trim(),
          phoneNumbers: [_phoneController.text.trim()],
          emails: [_emailController.text.trim()],
          notes: _notesController.text.trim(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await repo.addContact(newContact);
      }

      // Invalidate contacts provider to refresh list
      ref.invalidate(contactsProvider);

      if (mounted) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactToEdit != null ? 'Edit Contact' : 'Add Contact'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(AppTheme.spacingLg),
            children: [
              _buildTextField(
                controller: _firstNameController,
                label: 'First Name',
                icon: Icons.person_outline,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'First name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppTheme.spacingMd),
              
              _buildTextField(
                controller: _lastNameController,
                label: 'Last Name',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: AppTheme.spacingMd),
              
              _buildTextField(
                controller: _phoneController,
                label: 'Phone',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppTheme.spacingMd),
              
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppTheme.spacingMd),
              
              _buildTextField(
                controller: _notesController,
                label: 'Notes',
                icon: Icons.notes,
                maxLines: 4,
              ),
              const SizedBox(height: AppTheme.spacingXl),
              
              PrimaryButton(
                text: 'Save Contact',
                icon: Icons.save,
                onPressed: _isSaving ? null : _saveContact,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(color: AppTheme.onSurface),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppTheme.onSurfaceVariant.withOpacity(0.8)),
        prefixIcon: Icon(icon, color: AppTheme.onSurfaceVariant),
        filled: true,
        fillColor: AppTheme.surfaceVariant.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.outline.withOpacity(0.2)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.outline.withOpacity(0.2)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.tertiary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.error),
        ),
      ),
    );
  }
}
