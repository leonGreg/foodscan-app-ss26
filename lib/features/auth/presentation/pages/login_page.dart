import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/router/app_router.dart';
import 'package:food_scan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:food_scan/features/auth/presentation/widgets/auth_divider.dart';
import 'package:food_scan/features/auth/presentation/widgets/auth_error_message.dart';
import 'package:food_scan/features/auth/presentation/widgets/auth_header.dart';
import 'package:food_scan/features/auth/presentation/widgets/auth_switch_row.dart';
import 'package:food_scan/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:food_scan/features/auth/utils/auth_error_mapper.dart';
import 'package:food_scan/features/auth/utils/auth_validators.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  late AppLocalizations _l10n;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            context.go(AppRouter.home);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              AuthHeader(
                title: _l10n.loginTitle,
                subtitle: _l10n.loginSubtitle,
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
                        const SizedBox(height: AppDimensions.paddingMedium),
                        AuthTextField(
                          controller: _passwordController,
                          label: _l10n.passwordLabel,
                          obscureText: _obscurePassword,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                          validator: passwordValidator(_l10n),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _openForgotPassword,
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(
                                AppColors.primaryGreen,
                              ),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: Text(_l10n.forgotPassword),
                          ),
                        ),
                        if (state is AuthFailure) ...[
                          const SizedBox(height: AppDimensions.paddingMedium),
                          AuthErrorMessage(message: mapAuthErrorCode(state.code, _l10n)),
                        ],
                        const SizedBox(height: AppDimensions.paddingXLarge),
                        SizedBox(
                          height: AppDimensions.buttonHeightLarge,
                          child: ElevatedButton(
                            onPressed: state is AuthLoading ? null : _submit,
                            child: state is AuthLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    _l10n.loginButton,
                                    style: const TextStyle(
                                      fontSize: AppDimensions.fontSizeLarge,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: AppDimensions.paddingLarge),
                        const AuthDivider(),
                        const SizedBox(height: AppDimensions.paddingLarge),
                        AuthSwitchRow(
                          question: _l10n.noAccountYet,
                          actionLabel: _l10n.registerNow,
                          onTap: () => context.push(AppRouter.register),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openForgotPassword() {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      context.push(AppRouter.forgotPassword);
      return;
    }

    context.push(
      '${AppRouter.forgotPassword}?email=${Uri.encodeComponent(email)}',
    );
  }
}
