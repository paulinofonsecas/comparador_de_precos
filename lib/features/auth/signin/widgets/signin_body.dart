import 'package:comparador_de_precos/app/config/dependencies.dart';
import 'package:comparador_de_precos/features/auth/bloc/auth_bloc.dart';
import 'package:comparador_de_precos/features/auth/signin/bloc/bloc.dart';
import 'package:comparador_de_precos/features/auth/signin/bloc/signin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

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
          minHeight: 0,
          maxHeight: double.infinity,
          minWidth: 10,
          maxWidth: 550,
        ),
        child: BlocBuilder<SigninBloc, SigninState>(
          builder: (context, state) {
            if (state is SigninLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return _Body(
              formKey: _formKey,
              emailController: _emailController,
              focusNode: _focusNode,
              passwordController: _passwordController,
            );
          },
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    super.key,
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
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Spacer(),
            TextFormField(
              controller: _emailController,
              focusNode: _focusNode,
              decoration: const InputDecoration(
                hintText: 'Digite seu e-mail',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Digite sua senha',
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                ),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24),
            ElevatedButton(
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
            ),
            GutterMedium(),
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
            Gutter(),
            TextButton(
              onPressed: () {},
              child: Text(
                'Não tenho uma conta? Cadastre-se',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
