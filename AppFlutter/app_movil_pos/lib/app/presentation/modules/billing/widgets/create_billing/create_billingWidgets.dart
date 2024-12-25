import 'package:flutter/material.dart';

import '../../../../global/colors.dart';
import 'cellWidgets.dart';
import 'detailesWidgets.dart';
import 'sub_totalWidgets.dart';

class CreateBillingWidgets extends StatelessWidget {
  const CreateBillingWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = List.generate(1, (index) => 'Elemento $index');
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(3.0),
        //color: AppColors.fondo,
        decoration: BoxDecoration(
          color: AppColors.fondo,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.info,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CellWidgets(
                        flex: 4,
                        text: 'Cantidad',
                        color: Colors.white,
                      ),
                      CellWidgets(
                        flex: 6,
                        text: 'Descripcion',
                        color: Colors.white,
                      ),
                      CellWidgets(
                        flex: 3,
                        text: 'Precio',
                        color: Colors.white,
                      ),
                      CellWidgets(
                        flex: 2,
                        text: 'Desc.',
                        color: Colors.white,
                      ),
                      CellWidgets(
                        flex: 3,
                        text: 'Total',
                        color: Colors.white,
                      ),
                      CellWidgets(
                        flex: 1,
                        text: '-',
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.fondo,
                ),
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return const Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 25,
                          child: DetailesWidgets(),
                        ),
                        Divider(
                          color: AppColors.info,
                          indent: 5,
                          endIndent: 5,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            const SubTotalWidgets(),
          ],
        ),
      ),
    );
  }
}
