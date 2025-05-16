import 'package:comparador_de_precos/features/auth/signin/view/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// {@template signup_body}
/// Body of the SignupPage.
///
/// Add what it does
/// {@endtemplate}
class SignupBody extends StatelessWidget {
  /// {@macro signup_body}
  const SignupBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Column(
        children: [
          const Gutter(),
          const NameTextField(),
          const Gutter(),
          const EmailTextField(),
          const Gutter(),
          const BITextField(),
          const Gutter(),
          const PhoneTextField(),
          const Gutter(),
          const PasswordTextField(),
          const GutterLarge(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              minimumSize: const Size(double.infinity, 0),
              backgroundColor: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Cadastrar',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          const GutterMedium(),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Já tenho uma conta? Faça login',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um email';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class NameTextField extends StatelessWidget {
  const NameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um nome';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Nome',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class BITextField extends StatelessWidget {
  const BITextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um BI';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'BI',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um telefone';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Telefone',
        prefixIcon: Icon(Icons.phone),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira uma senha';
        }
        return null;
      },
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Senha',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
