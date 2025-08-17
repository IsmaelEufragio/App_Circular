import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/routes.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.uri,
  });

  final String uri;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(uri),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                GoRouter.of(context).pushReplacementNamed(
                  Routes.home,
                );
              },
              child: const Text('Go to home'),
            )
          ],
        ),
      ),
    );
  }
}
