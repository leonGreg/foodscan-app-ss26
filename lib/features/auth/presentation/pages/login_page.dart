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
              AuthHeader(title: 'Anmelden', subtitle: 'Willkommen zurück!'),
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
                          label: 'E-Mail',
                          keyboardType: TextInputType.emailAddress,
                          validator: _validateEmail,
                        ),
                        const SizedBox(height: AppDimensions.paddingMedium),
                        AuthTextField(
                          controller: _passwordController,
                          label: 'Passwort',
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
                                    'Anmelden',
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
                          question: 'Noch kein Konto?',
                          actionLabel: 'Jetzt registrieren',
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
