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
                title: 'Registrieren',
                subtitle: 'Neues Konto erstellen',
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
                          label: 'Name',
                          hint: 'Dein Name',
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Name ist erforderlich'
                              : null,
                        ),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        AuthTextField(
                          controller: _emailController,
                          label: 'E-Mail',
                          hint: 'ihre@email.de',
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        AuthTextField(
                          controller: _passwordController,
                          label: 'Passwort',
                          hint: 'Passwort eingeben',
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
                          validator: _validatePassword,
                        ),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        AuthTextField(
                          controller: _confirmPasswordController,
                          label: 'Passwort bestätigen',
                          hint: 'Passwort wiederholen',
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
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Passwort bestätigen ist erforderlich';
                            }
                            if (v != _passwordController.text) {
                              return 'Passwörter stimmen nicht überein';
                            }
                            return null;
                          },
                        ),
                        if (state is AuthFailure) ...[
                          const SizedBox(height: AppDimensions.paddingMedium),
                          AuthErrorMessage(message: state.message),
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
                                : const Text(
                                    'Registrieren',
                                    style: TextStyle(
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
                          question: 'Bereits ein Konto?',
                          actionLabel: 'Jetzt anmelden',
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

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'E-Mail ist erforderlich';
    if (!RegExp(r'^[\w\-.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(value.trim())) {
      return 'Ungültige E-Mail-Adresse';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Passwort ist erforderlich';
    if (value.length < 6) {
      return 'Passwort muss mindestens 6 Zeichen lang sein';
    }
    return null;
  }
}
