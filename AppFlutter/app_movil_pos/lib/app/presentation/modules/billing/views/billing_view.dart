import 'package:flutter/material.dart';

import '../../../global/colors.dart';
import '../../../global/widgets/icon_boton.dart';
import '../../../global/widgets/text_boton.dart';
import '../../../global/widgets/text_field_widget.dart';
import '../widgets/create_billing/create_billingWidgets.dart';
import '../widgets/select_produc/product.dart';

class BillingView extends StatefulWidget {
  const BillingView({super.key});

  @override
  State<BillingView> createState() => _BillingViewState();
}

class _BillingViewState extends State<BillingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          color: AppColors.fondo,
          child: LayoutBuilder(
            builder: (context, constraints) {
              double heightMax = constraints.maxHeight;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: SizedBox(
                      height: heightMax * 0.1,
                      child: const Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: TextFieldWidget(
                              hintText: 'Codigo, Nombre, Categoria, Precio',
                              textInputAction: TextInputAction.search,
                              suffixIcon: Icon(
                                Icons.search,
                                color: AppColors.inportante,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: double.infinity,
                              child: Row(
                                children: [
                                  IconBoton(
                                    iconData: Icons.filter_list_rounded,
                                  ),
                                  IconBoton(
                                    iconData: Icons.qr_code,
                                  ),
                                  IconBoton(
                                    iconData: Icons.receipt,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: TextFieldWidget(
                              hintText: 'Nombre del Cliente',
                              bottom: 8.0,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                              height: double.infinity,
                              child: Row(
                                children: [
                                  TextBoton(
                                    text: 'RTN',
                                  ),
                                  IconBoton(
                                    iconData: Icons.money_rounded,
                                  ),
                                  IconBoton(
                                    iconData: Icons.credit_card,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: heightMax * 0.83,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.all(3.0),
                            //color: AppColors.info.withOpacity(0.5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: AppColors.info,
                              ),
                              color: AppColors.info.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GridView.custom(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 80,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                ),
                                childrenDelegate: SliverChildBuilderDelegate(
                                  (_, __) {
                                    return const Product();
                                  },
                                  childCount: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const CreateBillingWidgets(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: heightMax * 0.07,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                              //color: Colors.red,
                              ),
                        ),
                        Expanded(
                          flex: 3,
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
                                  onPressed: () {},
                                  icon: const Icon(Icons.home),
                                  color: AppColors.fondo,
                                  padding: const EdgeInsets.all(0),
                                ),
                                IconButton(
                                  onPressed: () {},
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
                                  onPressed: () {},
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
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.alert,
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.delete),
                                      color: AppColors.alert,
                                      padding: const EdgeInsets.all(0),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.inportante,
                                      ),
                                    ),
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.check),
                                      color: AppColors.inportante,
                                      padding: const EdgeInsets.all(0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
