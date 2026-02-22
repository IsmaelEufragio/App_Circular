import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/user_crear_controller.dart';

class UserHeader extends StatelessWidget {
  const UserHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final contreller = context.watch<UserCrearController>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.42),
        Center(
          child: GestureDetector(
            onTap: () => _showImagePickerOptions(context, contreller),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[400]!, width: 2),
              ),
              child: contreller.state.logo != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        contreller.state.logo!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate,
                          size: 48,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Agregar logo',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        if (contreller.state.logo != null) ...[
          const SizedBox(height: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  _showImagePickerOptions(context, contreller);
                },
                icon: const Icon(Icons.edit),
                label: const Text('Cambiar'),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.delete, color: Colors.red),
                label:
                    const Text('Eliminar', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _showImagePickerOptions(
      BuildContext context, UserCrearController controller) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Elegir de galería'),
                onTap: () {
                  Navigator.pop(context);
                  controller.pickLogoFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.grey),
                title: const Text('Cancelar'),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
