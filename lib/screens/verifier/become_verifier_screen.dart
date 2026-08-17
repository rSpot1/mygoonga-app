import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../services/verifier_service.dart';
import '../../theme/app_colors.dart';

class BecomeVerifierScreen extends StatefulWidget {
  const BecomeVerifierScreen({super.key});

  @override
  State<BecomeVerifierScreen> createState() => _BecomeVerifierScreenState();
}

class _BecomeVerifierScreenState extends State<BecomeVerifierScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  String? _cniFrontPath;
  String? _cniBackPath;
  String? _verificationPhotoPath;
  bool _isSubmitting = false;
  String? _error;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pick(void Function(String path) onPicked, {bool front = true}) async {
    final picked = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 90);
    if (picked != null) onPicked(picked.path);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;
    if (_cniFrontPath == null || _cniBackPath == null || _verificationPhotoPath == null) {
      setState(() => _error = l10n.verifierPhotosRequiredError);
      return;
    }
    setState(() {
      _isSubmitting = true;
      _error = null;
    });
    try {
      await VerifierService.instance.apply(
        phoneNumber: _phoneController.text.trim(),
        cniFrontPath: _cniFrontPath!,
        cniBackPath: _cniBackPath!,
        verificationPhotoPath: _verificationPhotoPath!,
      );
      if (mounted) {
        await context.read<AuthProvider>().refreshProfile();
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.verifierRequestSentSnackbar)),
        );
      }
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.verifierAppBarTitle)),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.insufficientBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.privacy_tip_outlined, size: 20, color: AppColors.insufficient),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.verifierPrivacyNotice,
                          style: const TextStyle(fontSize: 12.5, color: AppColors.insufficient),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (_error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.doubtfulBg, borderRadius: BorderRadius.circular(10)),
                    child: Text(_error!, style: const TextStyle(color: AppColors.doubtful, fontSize: 13)),
                  ),
                  const SizedBox(height: 16),
                ],
                Text(l10n.verifierPhoneLabel, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(hintText: '+237 6XX XXX XXX'),
                  validator: (v) => (v == null || v.trim().length < 8) ? l10n.verifierPhoneInvalid : null,
                ),
                const SizedBox(height: 22),
                _DocumentPickerTile(
                  title: l10n.verifierCniFrontTitle,
                  path: _cniFrontPath,
                  onTap: () => _pick((p) => setState(() => _cniFrontPath = p)),
                ),
                const SizedBox(height: 10),
                _DocumentPickerTile(
                  title: l10n.verifierCniBackTitle,
                  path: _cniBackPath,
                  onTap: () => _pick((p) => setState(() => _cniBackPath = p)),
                ),
                const SizedBox(height: 10),
                _DocumentPickerTile(
                  title: l10n.verifierPhotoTitle,
                  path: _verificationPhotoPath,
                  onTap: () => _pick((p) => setState(() => _verificationPhotoPath = p)),
                ),
                const SizedBox(height: 28),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                        )
                      : Text(l10n.verifierSubmitButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DocumentPickerTile extends StatelessWidget {
  final String title;
  final String? path;
  final VoidCallback onTap;

  const _DocumentPickerTile({required this.title, required this.path, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasFile = path != null;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: hasFile ? AppColors.reliableBg : AppColors.surfaceAlt,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: hasFile ? AppColors.reliable.withValues(alpha: 0.3) : AppColors.border),
        ),
        child: Row(
          children: [
            if (hasFile)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(File(path!), width: 44, height: 44, fit: BoxFit.cover),
              )
            else
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.photo_camera_outlined, color: AppColors.textMuted),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13.5)),
            ),
            Icon(
              hasFile ? Icons.check_circle : Icons.chevron_right,
              color: hasFile ? AppColors.reliable : AppColors.textMuted,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
