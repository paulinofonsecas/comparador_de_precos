import 'package:comparador_de_precos/features/auth/signin/bloc/bloc.dart';
import 'package:comparador_de_precos/features/auth/signup/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:hugeicons/hugeicons.dart';

/// {@template signin_body}
/// Body of the SigninPage.
///
/// Add what it does
/// {@endtemplate}
class SigninBody extends StatefulWidget {
  /// {@macro signin_body}
  const SigninBody({super.key});

  @override
  State<SigninBody> createState() => _SigninBodyState();
}

class _SigninBodyState extends State<SigninBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController =
      TextEditingController(text: 'paulinofonsecass@gmail.com');
  final _passwordController = TextEditingController(text: 'SuperAdmin1.23');
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: 10,
          maxWidth: 550,
        ),
        child: _Body(
          formKey: _formKey,
          emailController: _emailController,
          focusNode: _focusNode,
          passwordController: _passwordController,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required FocusNode focusNode,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _focusNode = focusNode,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final FocusNode _focusNode;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Spacer(),
            const Icon(
              HugeIcons.strokeRoundedHotPrice,
              size: 100,
            ),
            const GutterLarge(),
            const Text(
              'COMPARADOR DE PREÇOS',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1,
              ),
            ),
            const Spacer(),
            EmailTextField(
              emailController: _emailController,
              focusNode: _focusNode,
            ),
            const Gutter(),
            SenhaTextField(passwordController: _passwordController),
            const GutterLarge(),
            _buildEntrarButton(context),
            const GutterMedium(),
            TextButton(
              onPressed: () {},
              child: Text(
                'Esqueci minha senha',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const Gutter(),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(SignupPage.route());
              },
              child: Text(
                'Não tenho uma conta? Cadastre-se',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }

  Widget _buildEntrarButton(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(
      builder: (context, state) {
        if (state is SigninLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ElevatedButton(
          onPressed: () {
            final email = _emailController.text;
            final password = _passwordController.text;

            if (_formKey.currentState!.validate()) {
              context.read<SigninBloc>().add(
                    SigninWithEmailAndPasswordEvent(
                      email: email,
                      password: password,
                    ),
                  );
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
            'Entrar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        );
      },
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({
    required TextEditingController emailController, required FocusNode focusNode, super.key,
  })  : _emailController = emailController,
        _focusNode = focusNode;

  final TextEditingController _emailController;
  final FocusNode _focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _emailController,
      focusNode: _focusNode,
      decoration: const InputDecoration(
        hintText: 'Digite seu e-mail',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }
}

class SenhaTextField extends StatelessWidget {
  const SenhaTextField({
    required TextEditingController passwordController, super.key,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _passwordController,
      decoration: const InputDecoration(
        hintText: 'Digite sua senha',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      obscureText: true,
    );
  }
}
