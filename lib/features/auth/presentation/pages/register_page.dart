import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  late AppLocalizations _l10n;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        RegisterRequested(
          email: _emailController.text,
          password: _passwordController.text,
          displayName: _nameController.text,
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
                title: _l10n.registerTitle,
                subtitle: _l10n.registerSubtitle,
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
                          controller: _nameController,
                          label: _l10n.nameLabel,
                          validator: displayNameValidator(_l10n),
                        ),
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
                        const SizedBox(height: AppDimensions.paddingMedium),
                        AuthTextField(
                          controller: _confirmPasswordController,
                          label: _l10n.confirmPasswordLabel,
                          obscureText: _obscureConfirm,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirm
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            onPressed: () => setState(
                              () => _obscureConfirm = !_obscureConfirm,
                            ),
                          ),
                          validator: confirmPasswordValidator(_l10n, _passwordController.text),
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
                                    _l10n.registerButton,
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
                          question: _l10n.alreadyHaveAccount,
                          actionLabel: _l10n.loginNow,
                          onTap: () => context.go(AppRouter.login),
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

}
