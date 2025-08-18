import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/colors.dart';
import '../../../global/controllers/session_controller.dart';
import '../Widget/dayBox.dart';
import '../Widget/iconWithCounter.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<SessionController>().state!;
    final telefonos = user.telefonos.map((e) => e.telefono).join(', ');
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.blue,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      bottom: -20, // 👈 Se sale por arriba
                      left: MediaQuery.of(context).size.width / 2 - 60,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white, // color del borde
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            'https://img.freepik.com/vector-premium/logo-granja-pollos_623665-622.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text(
                user.nombre,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.alert),
              ),
              Text(
                user.despcripcion,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.fondo75,
                ),
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 278,
                    height: 25,
                  ),
                  Container(
                    width: 300,
                    height: 28,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.fondo,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2,
                        )),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Iconwithcounter(
                            icon: Icons.favorite_border, number: '12'),
                        SizedBox(width: 16),
                        Iconwithcounter(
                            icon: Icons.heart_broken_outlined, number: '5'),
                        SizedBox(width: 16),
                        Iconwithcounter(icon: Icons.compost, number: '8'),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.facebook),
                              color: AppColors.primary,
                            ),
                            Text(
                              user.fecebook,
                              style: const TextStyle(
                                color: AppColors.info,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.phone),
                              color: AppColors.primary,
                            ),
                            Text(
                              telefonos,
                              style: const TextStyle(
                                color: AppColors.info,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.local_shipping),
                              color: AppColors.primary,
                            ),
                            const Text('SI'),
                          ],
                        ),
                        Row(
                          children: [
                            Wrap(
                              spacing: 5, // espacio horizontal
                              runSpacing: 5, // espacio vertical
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.alert,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'microempresa',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Hogar',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Oficina',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Muebles',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.schedule),
                              color: AppColors.primary,
                            ),
                            const Text('7:000 AM - 9:00 PM'),
                            const SizedBox(width: 5),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            )
                          ],
                        ),
                        const Row(
                          children: [
                            Daybox(text: 'Lu'),
                            Daybox(text: 'Ma'),
                            Daybox(text: 'Mi'),
                            Daybox(text: 'Ju'),
                            Daybox(text: 'Vi'),
                            Daybox(text: 'Sa'),
                            Daybox(text: 'Do'),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.redeem),
                              color: AppColors.primary,
                            ),
                            const Text(
                              'Instagran',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.location_on),
                              color: AppColors.primary,
                            ),
                            const Text(
                              'Av. 10 de agosto y 6 de diciembre',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
