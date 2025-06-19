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
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

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
        body: SafeArea(
          child: Container(
            color: AppColors.fondo,
            child: Align(
              alignment: Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.info,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      child: Builder(
                        builder: (context) {
                          final controlle =
                              Provider.of<SignInController>(context);
                          return AbsorbPointer(
                            absorbing: controlle.state.fetching,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (text) {
                                    controlle.onUserNameChanged(text);
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Usuario',
                                  ),
                                  validator: (text) {
                                    text = text?.trim().toLowerCase() ?? '';
                                    if (text.isEmpty) {
                                      return 'Ingrese un usuario valid';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  onChanged: (text) {
                                    controlle.onPasswordChanged(text);
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Contraseña',
                                  ),
                                  validator: (text) {
                                    text = text?.replaceAll(' ', '') ?? '';
                                    if (text.length < 4) {
                                      return 'Tiene que tener almanos 4 caracteres.';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const SubmitButton()
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // Espera un frame y luego desplaza
        Future.delayed(const Duration(milliseconds: 300), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      }
    });
  }
}
/*
class SingInView extends StatelessWidget {
  const SingInView({super.key});

  // ignore: unused_field
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
        //resizeToAvoidBottomInset: true,

        body: SafeArea(
          child: Container(
            color: AppColors.fondo,
            child: Align(
              alignment: Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.info,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  //margin: const EdgeInsets.all(30),
                  child: Form(
                    child: Builder(
                      builder: (context) {
                        final controlle =
                            Provider.of<SignInController>(context);
                        return AbsorbPointer(
                          absorbing: controlle.state.fetching,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (text) {
                                  controlle.onUserNameChanged(text);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Usuario',
                                ),
                                validator: (text) {
                                  text = text?.trim().toLowerCase() ?? '';
                                  if (text.isEmpty) {
                                    return 'Ingrese un usuario valid';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (text) {
                                  controlle.onPasswordChanged(text);
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Contraseña',
                                ),
                                validator: (text) {
                                  text = text?.replaceAll(' ', '') ?? '';
                                  if (text.length < 4) {
                                    return 'Tiene que tener almanos 4 caracteres.';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const SubmitButton()
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/