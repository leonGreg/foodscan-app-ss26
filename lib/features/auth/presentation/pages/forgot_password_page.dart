import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/router/app_router.dart';
import 'package:food_scan/features/auth/data/services/auth_service.dart';
import 'package:food_scan/features/auth/presentation/widgets/auth_error_message.dart';
import 'package:food_scan/features/auth/presentation/widgets/auth_header.dart';
import 'package:food_scan/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:food_scan/features/auth/utils/auth_error_mapper.dart';
import 'package:food_scan/features/auth/utils/auth_validators.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String initialEmail;

  const ForgotPasswordPage({super.key, this.initialEmail = ''});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;
  late AppLocalizations _l10n;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.initialEmail;
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _authService.sendPasswordResetEmail(_emailController.text);
      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: Text(_l10n.resetEmailSent)));

      if (context.canPop()) {
        context.pop();
      } else {
        context.go(AppRouter.login);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = mapAuthErrorCode(e.code, _l10n);
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = _l10n.forgotPasswordErrorGeneric;
      });
    }
  }

  void _backToLogin() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    _l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          AuthHeader(
            title: _l10n.forgotPasswordTitle,
            subtitle: _l10n.forgotPasswordSubtitle,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppDimensions.paddingMedium),
                    AuthTextField(
                      controller: _emailController,
                      label: _l10n.emailLabel,
                      keyboardType: TextInputType.emailAddress,
                      validator: emailValidator(_l10n),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: AppDimensions.paddingMedium),
                      AuthErrorMessage(message: _errorMessage!),
                    ],
                    const SizedBox(height: AppDimensions.paddingXLarge),
                    SizedBox(
                      height: AppDimensions.buttonHeightLarge,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _submit,
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _l10n.forgotPasswordButton,
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontSizeLarge,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),
                    TextButton(
                      onPressed: _backToLogin,
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(AppColors.primaryGreen),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      child: Text(_l10n.backToLogin),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
