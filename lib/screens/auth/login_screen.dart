import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/auth_service.dart';
import '../../theme/app_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isRegisterMode = false;
  bool _isSubmitting = false;
  bool _obscurePassword = true;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitEmailForm() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    try {
      if (_isRegisterMode) {
        await AuthService.instance.registerWithEmail(_emailController.text.trim(), _passwordController.text);
      } else {
        await AuthService.instance.signInWithEmail(_emailController.text.trim(), _passwordController.text);
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _errorMessage = _firebaseErrorLabel(l10n, e.code));
    } catch (e) {
      setState(() => _errorMessage = l10n.loginGenericError);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _submitGoogleSignIn() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });
    try {
      await AuthService.instance.signInWithGoogle();
    } catch (e) {
      setState(() => _errorMessage = l10n.loginGoogleError);
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String _firebaseErrorLabel(AppLocalizations l10n, String code) {
    switch (code) {
      case 'user-not-found':
        return l10n.loginErrorUserNotFound;
      case 'wrong-password':
      case 'invalid-credential':
        return l10n.loginErrorWrongPassword;
      case 'email-already-in-use':
        return l10n.loginErrorEmailInUse;
      case 'weak-password':
        return l10n.loginErrorWeakPassword;
      case 'invalid-email':
        return l10n.loginErrorInvalidEmail;
      default:
        return l10n.loginErrorGenericCode(code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                Container(
                  width: 68,
                  height: 68,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.brand.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(Icons.shield_moon_outlined, size: 34, color: AppColors.brand),
                ),
                const SizedBox(height: 20),
                Text(
                  _isRegisterMode ? l10n.loginCreateAccountTitle : l10n.loginWelcomeBackTitle,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  _isRegisterMode ? l10n.loginRegisterSubtitle : l10n.loginSignInSubtitle,
                  style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 32),
                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.doubtfulBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.error_outline, size: 18, color: AppColors.doubtful),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(_errorMessage!, style: const TextStyle(color: AppColors.doubtful, fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: l10n.loginEmailHint,
                    prefixIcon: const Icon(Icons.mail_outline, size: 20),
                  ),
                  validator: (v) => (v == null || !v.contains('@')) ? l10n.loginEmailInvalid : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: l10n.loginPasswordHint,
                    prefixIcon: const Icon(Icons.lock_outline, size: 20),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined, size: 20),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) => (v == null || v.length < 6) ? l10n.loginPasswordTooShort : null,
                ),
                if (!_isRegisterMode) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _isSubmitting
                          ? null
                          : () async {
                              if (_emailController.text.trim().isEmpty) {
                                setState(() => _errorMessage = l10n.loginEnterEmailForReset);
                                return;
                              }
                              await AuthService.instance.sendPasswordResetEmail(_emailController.text.trim());
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(l10n.loginResetEmailSent)),
                                );
                              }
                            },
                      child: Text(l10n.loginForgotPassword),
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitEmailForm,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                        )
                      : Text(_isRegisterMode ? l10n.loginCreateAccountButton : l10n.loginSignInButton),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(child: Divider(color: Theme.of(context).dividerColor)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(l10n.loginOrDivider, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    ),
                    Expanded(child: Divider(color: Theme.of(context).dividerColor)),
                  ],
                ),
                const SizedBox(height: 18),
                OutlinedButton.icon(
                  onPressed: _isSubmitting ? null : _submitGoogleSignIn,
                  icon: const Icon(Icons.g_mobiledata, size: 26),
                  label: Text(l10n.loginContinueWithGoogle),
                ),
                const SizedBox(height: 28),
                Center(
                  child: TextButton(
                    onPressed: _isSubmitting
                        ? null
                        : () => setState(() {
                              _isRegisterMode = !_isRegisterMode;
                              _errorMessage = null;
                            }),
                    child: Text(
                      _isRegisterMode ? l10n.loginSwitchToSignIn : l10n.loginSwitchToRegister,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
