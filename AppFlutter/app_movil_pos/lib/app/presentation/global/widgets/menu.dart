import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../routes/routes.dart';
import '../colors.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 0,
          left: 170,
          right: 170,
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.info,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.only(bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(
                          Routes.home,
                        );
                      },
                      icon: const Icon(Icons.home),
                      color: AppColors.fondo,
                      padding: const EdgeInsets.all(0),
                    ),
                    IconButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(
                          Routes.billing,
                        );
                      },
                      icon: const Icon(Icons.receipt),
                      color: AppColors.fondo,
                      padding: const EdgeInsets.all(0),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.store),
                      color: AppColors.fondo,
                      padding: const EdgeInsets.all(0),
                    ),
                    IconButton(
                      onPressed: () {
                        GoRouter.of(context).pushNamed(
                          Routes.profile,
                        );
                      },
                      icon: const Icon(Icons.engineering),
                      color: AppColors.fondo,
                      padding: const EdgeInsets.all(0),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.print),
                      color: AppColors.fondo,
                      padding: const EdgeInsets.all(0),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.inventory),
                      color: AppColors.fondo,
                      padding: const EdgeInsets.all(0),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.campaign),
                      color: AppColors.fondo,
                      padding: const EdgeInsets.all(0),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.recycling),
                      color: AppColors.fondo,
                      padding: const EdgeInsets.all(0),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.post_add),
                      color: AppColors.fondo,
                      padding: const EdgeInsets.all(0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
