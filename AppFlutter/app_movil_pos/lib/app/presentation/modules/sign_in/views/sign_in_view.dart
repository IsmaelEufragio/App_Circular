import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/colors.dart';
import '../controller/sign_in_controller.dart';
import '../controller/state/sign_in_state.dart';
import 'widgets/submit_button.dart';

class SingInView extends StatefulWidget {
  const SingInView({super.key});

  @override
  State<SingInView> createState() => _SingInViewState();
}

class _SingInViewState extends State<SingInView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(
        const SignInState(),
        //Ya estan en main, es solo los castea.
        sessionController: context.read(),
        authenticationRepository: context.read(),
      ),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.sucess,
                AppColors.primary,
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 80.0)
                  .copyWith(top: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bienvenido',
                    style: TextStyle(
                      color: AppColors.fondo,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Inicia sesión para continuar',
                    style: TextStyle(
                      color: AppColors.fondo75,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.fondo,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: AppColors.info,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      child: Builder(
                        builder: (context) {
                          final controlle =
                              Provider.of<SignInController>(context);
                          return AbsorbPointer(
                            absorbing: controlle.state.fetching,
                            child: Column(
                              children: [
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Correo electrónico',
                                    prefixIcon:
                                        const Icon(Icons.email_outlined),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (text) {
                                    controlle.onUserNameChanged(text);
                                  },
                                  validator: (text) {
                                    text = text?.trim().toLowerCase() ?? '';
                                    if (text.isEmpty) {
                                      return 'Ingrese un correo valido';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Contraseña',
                                    prefixIcon: const Icon(Icons.lock_outlined),
                                    suffixIcon: IconButton(
                                      icon:
                                          const Icon(Icons.visibility_outlined),
                                      onPressed: () {},
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (text) {
                                    controlle.onPasswordChanged(text);
                                  },
                                  validator: (text) {
                                    text = text?.replaceAll(' ', '') ?? '';
                                    if (text.length < 4) {
                                      return 'Tiene que tener almanos 4 caracteres.';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Checkbox(
                                      value:
                                          Provider.of<SignInController>(context)
                                              .state
                                              .rememberCredentials,
                                      onChanged: (value) {
                                        setState(() {
                                          controlle
                                              .onRememberCredentialsChanged(
                                                  value ?? false);
                                        });
                                      },
                                    ),
                                    const Text(
                                      'Recordar credenciales',
                                      style: TextStyle(
                                        color: AppColors.sucess,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        '¿Olvidaste tu contraseña?',
                                        style: TextStyle(
                                          color: AppColors.sucess,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                //const SizedBox(height: 12),
                                const SizedBox(
                                  width: double.infinity,
                                  height: 45,
                                  child: SubmitButton(),
                                ),
                                const SizedBox(height: 16),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  //const SizedBox(height: 24),
                  TextButton(
                    onPressed: () {},
                    child: const Text.rich(
                      TextSpan(
                        text: '¿No tienes una cuenta? ',
                        style: TextStyle(color: AppColors.fondo75),
                        children: [
                          TextSpan(
                            text: 'Regístrate',
                            style: TextStyle(
                              color: AppColors.fondo,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
