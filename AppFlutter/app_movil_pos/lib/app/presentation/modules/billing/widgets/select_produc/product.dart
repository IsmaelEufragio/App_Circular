import 'package:flutter/material.dart';

import '../../../../global/colors.dart';
import 'description.dart';
import 'details_producto.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.fondo,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                'https://images-na.ssl-images-amazon.com/images/I/61whKHqiewL._SL1433_.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DescriptionProduct(
                  text: 'Mesa De Hierror con un texto mas grande',
                  fontSize: 8,
                  color: AppColors.alert,
                  fontWeight: FontWeight.bold,
                  softWrap: true,
                ),
                DetailsProduct(
                  titulo: 'Existencia:',
                  description: '10',
                ),
                DetailsProduct(
                  titulo: 'Codigo:',
                  description: 'HG-0001',
                ),
                DetailsProduct(
                  titulo: 'Descuento:',
                  description: '0%',
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    //color: AppColors.alert,
                    decoration: const BoxDecoration(
                      color: AppColors.alert,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          5,
                        ),
                        bottomLeft: Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    child: const Center(
                      child: DescriptionProduct(
                        text: 'Hogar',
                        fontSize: 10,
                        color: AppColors.fondo,
                        fontWeight: FontWeight.bold,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: DescriptionProduct(
                      text: '1500 lp',
                      fontSize: 11,
                      color: AppColors.sucess,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
