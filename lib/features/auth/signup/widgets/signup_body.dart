import 'package:comparador_de_precos/app/params/new_user_form_param.dart';
import 'package:comparador_de_precos/features/auth/signin/bloc/bloc.dart';
import 'package:comparador_de_precos/features/auth/signup/bloc/signup_bloc.dart';
import 'package:comparador_de_precos/features/auth/signup/view/solicitar_cadastro_loja_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:nif_validator/nif_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
            BITextField(
              controller: _biController,
              nameController: _nameController,
            ),
            const Gutter(),
            NameTextField(
              controller: _nameController,
              enabled: false,
            ),
            const Gutter(),
            EmailTextField(
              controller: _emailController,
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
                  final telefone = _telefoneController.text.replaceAll(' ', '');
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

        if (!EmailValidator(
          errorText: 'Por favor, insira um email válido',
        ).isValid(value)) {
          return 'Por favor, insira um email válido';
        }

        return null;
      },
      inputFormatters: [],
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
  const NameTextField(
      {required this.controller, this.enabled = true, super.key});

  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: !enabled,
      decoration: const InputDecoration(
        labelText: 'Nome',
        hintText: 'O nome será preenchido automaticamente a partir do BI',
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

class BITextField extends StatefulWidget {
  const BITextField(
      {required this.controller, super.key, required this.nameController});

  final TextEditingController controller;
  final TextEditingController nameController;

  @override
  State<BITextField> createState() => _BITextFieldState();
}

class _BITextFieldState extends State<BITextField> {
  var isLoading = false;
  var isError = false;
  var errorMessage = '';
  var nif = '';

  @override
  void initState() {
    widget.controller.addListener(() async {
      if (widget.controller.text.length == 14 && nif.isEmpty) {
        setState(() {
          isLoading = true;
          isError = false;
          errorMessage = '';
        });
        final bi = widget.controller.text;
        final nifValidator = NIFValidator();
        final result = await nifValidator.validate(bi);

        if (result is NIFValidatorResponse) {
          setState(() {
            isLoading = false;
            isError = false;
            errorMessage = '';
            nif = result.nif;
            widget.controller.text = bi;
            widget.nameController.text = result.name;
          });
        } else {
          setState(() {
            isLoading = false;
            isError = true;
            errorMessage = (result as NIFValidatorError).message;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var maskFormatter = new MaskTextInputFormatter(
      mask: '#########AA###',
      filter: {
        "#": RegExp(r'[0-9]'),
        "A": RegExp(r'[a-zA-Z]'),
      },
      type: MaskAutoCompletionType.lazy,
    );

    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, insira um BI';
            }

            final regex = RegExp(r'^\d{9}([A-Z]{2})\d{3}$');
            if (!regex.hasMatch(value)) {
              return 'Por favor, insira um BI válido';
            }

            return null;
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(14),
            maskFormatter,
          ],
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
        ),
        if (isLoading) const LinearProgressIndicator(),
        if (isError)
          Text(
            errorMessage,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
      ],
    );
  }
}

class PhoneTextField extends StatelessWidget {
  const PhoneTextField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(mask: "### ### ###");

    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor, insira um telefone';
        }
        return null;
      },
      inputFormatters: [
        // LengthLimitingTextInputFormatter(9),
        maskFormatter,
      ],
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
