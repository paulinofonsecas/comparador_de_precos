import 'package:comparador_de_precos/app/params/new_user_form_param.dart';
import 'package:comparador_de_precos/features/auth/signin/bloc/bloc.dart';
import 'package:comparador_de_precos/features/auth/signup/bloc/signup_bloc.dart';
import 'package:comparador_de_precos/features/auth/signup/view/solicitar_cadastro_loja_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// {@template signup_body}
/// Body of the SignupPage.
///
/// Add what it does
/// {@endtemplate}
class SignupBody extends StatefulWidget {
  /// {@macro signup_body}
  const SignupBody({super.key});

  @override
  State<SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<SignupBody> {
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _biController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Form(
        key: _form,
        child: Column(
          children: [
            NameTextField(
              controller: _nameController,
            ),
            const Gutter(),
            EmailTextField(
              controller: _emailController,
            ),
            const Gutter(),
            BITextField(
              controller: _biController,
            ),
            const Gutter(),
            PhoneTextField(
              controller: _telefoneController,
            ),
            const Gutter(),
            PasswordTextField(
              controller: _senhaController,
            ),
            const GutterLarge(),
            ElevatedButton(
              onPressed: () {
                if (_form.currentState!.validate()) {
                  final name = _nameController.text;
                  final email = _emailController.text;
                  final bi = _biController.text;
                  final telefone = _telefoneController.text;
                  final senha = _senhaController.text;

                  final newUserFormParam = NewUserFormParam(
                    name: name,
                    email: email,
                    bi: bi,
                    telefone: telefone,
                    senha: senha,
                  );

                  context
                      .read<SignupBloc>()
                      .add(CadastrarNovoUsuarioEvent(newUserFormParam));
                }
              },
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
                'Já tem uma conta? Faça login',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const SolicitarCadastroLojaPage(),
                  ),
                );
              },
              child: Text(
                'Deseja cadastrar uma loja?',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
  const NameTextField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
  const BITextField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
  const PhoneTextField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
  const PasswordTextField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
