import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackaton_2024_mv/feature/auth/login/presentation/notifier/login_state_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomHero(),
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: const FormLogin(),
            )
          ],
        ),
      ),
    );
  }
}

class CustomHero extends StatelessWidget {
  const CustomHero({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(width: 16.0),
          Text('Login Screen'),
        ],
      ),
    );
  }
}

class FormLogin extends ConsumerWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String? emailErrorMessage = ref
        .watch(loginStateProvider.select((value) => value.email.errorMessage));
    final passwordErrorMessage = ref.watch(
        loginStateProvider.select((value) => value.password.errorMessage));

    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Inicia sesión',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            /// Email
            CustomTextFormField(
              labelText: 'Usuario',
              onChanged: (value) {
                ref.read(loginStateProvider.notifier).onEmailChanged(value);
              },
              emailErrorMessage: emailErrorMessage,
            ),

            const SizedBox(height: 16),

            /// Password
            CustomTextFormField(
              labelText: 'Contraseña',
              onChanged: (value) {
                ref.read(loginStateProvider.notifier).onPasswordChanged(value);
              },
              emailErrorMessage: passwordErrorMessage,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
            ),

            const SizedBox(height: 16),

            /// Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ref.read(loginStateProvider.notifier).login();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF86efac)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 12.0)),
                ),
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.emailErrorMessage,
    required this.onChanged,
    this.obscureText = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
  });

  final String labelText;
  final String? emailErrorMessage;
  final Function(String value) onChanged;
  final bool obscureText;
  final bool enableSuggestions;
  final bool autocorrect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4.0),
        TextFormField(
          decoration: InputDecoration(
            errorText: emailErrorMessage,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          onChanged: (String value) {
            onChanged(value);
          },
          obscureText: obscureText,
          enableSuggestions: enableSuggestions,
          autocorrect: autocorrect,
        ),
      ],
    );
  }
}
