import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../../../../../generated/translations.g.dart';
import '../../../../routes/routes.dart';
import '../../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final SignInController controller = Provider.of(context);
    if (controller.state.fetching) {
      return const CircularProgressIndicator();
    }
    return MaterialButton(
      onPressed: () {
        final isValid = Form.of(context).validate();
        if (isValid) {
          _submit(context);
        }
      },
      color: Colors.blue,
      child: const Text('Login'),
    );
  }

  Future<void> _submit(BuildContext context) async {
    //final controlle = Provider.of<SignInController>(context);
    final SignInController controlle = context.read<SignInController>();
    final result = await controlle.submit();

    if (!controlle.mounted) return;

    result.when(
      left: (failure) {
        final message = failure.when(
          notFound: () => 'No encontrado',
          network: () => 'Erro de red',
          unauthorized: () => 'No autorizado',
          unknown: () => 'Desconocido',
          notVerified: () => 'No verifiacdo',
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
        return message;
      },
      right: (_) => Navigator.pushReplacementNamed(context, Routes.home),
    );
  }
}
