import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/user/schedule/schedule.dart';
import '../../../global/colors.dart';
import '../controller/user_crear_controller.dart';
import '../widgets/user_dropdow.dart';

class UserCrearScheduleView extends StatefulWidget {
  const UserCrearScheduleView({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  State<UserCrearScheduleView> createState() => _UserCrearScheduleViewState();
}

class _UserCrearScheduleViewState extends State<UserCrearScheduleView> {
  TimeOfDay _horaApertura = const TimeOfDay(hour: 9, minute: 0);

  TimeOfDay _horaCierre = const TimeOfDay(hour: 18, minute: 0);
  final Map<String, int> _dias = {
    'Lu': 1,
    'Ma': 2,
    'Mi': 3,
    'Ju': 4,
    'Vi': 5,
    'Sa': 6,
    'Do': 7
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Form(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Horario de Atención',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.sucess),
            ),
            const SizedBox(height: 10),
            _buildHorarioSection(
              titulo: 'Abre',
              horaActual: _horaApertura,
              onHoraChanged: (hora) {
                setState(() => _horaApertura = hora);
              },
            ),
            const SizedBox(height: 16),
            _buildHorarioSection(
              titulo: 'Cierra',
              horaActual: _horaCierre,
              onHoraChanged: (hora) {
                setState(() => _horaCierre = hora);
              },
            ),
            const SizedBox(height: 24),
            // Días de la semana
            _buildDiasSemana(context),
          ],
        )),
      ),
    );
  }

  Widget _buildHorarioSection({
    required String titulo,
    required TimeOfDay horaActual,
    required ValueChanged<TimeOfDay> onHoraChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 180),
          child: Text(
            titulo,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: AppColors.sucess),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Selector de Hora
            _buildTimeSelector(
              value: horaActual.hour,
              onChanged: (value) {
                onHoraChanged(
                    TimeOfDay(hour: value, minute: horaActual.minute));
              },
              isHour: true,
            ),
            const SizedBox(width: 8),
            const Text('Hora', style: TextStyle(color: Colors.grey)),

            const SizedBox(width: 24),

            // Selector de Minuto
            _buildTimeSelector(
              value: horaActual.minute,
              onChanged: (value) {
                onHoraChanged(TimeOfDay(hour: horaActual.hour, minute: value));
              },
              isHour: false,
            ),
            const SizedBox(width: 8),
            const Text('Minuto', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSelector({
    required int value,
    required ValueChanged<int> onChanged,
    required bool isHour,
  }) {
    final List<int> opciones = isHour
        ? List.generate(24, (index) => index) // 0-23
        : [0, 15, 30, 45]; // Minutos comunes

    return Container(
      width: 150,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: UserDropdow<int>(
        selectedValue: value,
        label: isHour ? 'Hora' : 'Minuto',
        option: opciones
            .map((opt) => DropdownMenuEntry<int>(
                  value: opt,
                  label: opt.toString().padLeft(2, '0'),
                ))
            .toList(),
        onSelected: (newValue) {
          if (newValue != null) {
            onChanged(newValue);
          }
        },
      ),
    );
  }

  Widget _buildDiasSemana(BuildContext context) {
    final controller = context.read<UserCrearController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Días de apertura, (Las horas seleccionadas se apicaran a estos días)',
          style:
              TextStyle(fontWeight: FontWeight.w500, color: AppColors.sucess),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _dias.keys.map((dia) {
            bool existeEnHorarios = controller.state.horarios
                .any((schedule) => schedule.diaNumero == _dias[dia]);
            return FilterChip(
              label: Text(
                dia,
                style: TextStyle(
                    color: existeEnHorarios ? AppColors.fondo : AppColors.info),
              ),
              selectedColor: AppColors.primary.withValues(alpha: 0.7),
              backgroundColor: AppColors.fondo,
              side: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
              selected: existeEnHorarios,
              onSelected: (selected) {
                if (selected) {
                  controller.onScheduleChanged([
                    ...controller.state.horarios,
                    Schedule(
                      diaNumero: _dias[dia]!,
                      horaInicio:
                          '${_horaApertura.hour.toString().padLeft(2, '0')}:${_horaApertura.minute.toString().padLeft(2, '0')}',
                      horaFin:
                          '${_horaCierre.hour.toString().padLeft(2, '0')}:${_horaCierre.minute.toString().padLeft(2, '0')}',
                    )
                  ]);
                } else {
                  controller.onScheduleChanged(
                    controller.state.horarios
                        .where((schedule) => schedule.diaNumero != _dias[dia])
                        .toList(),
                  );
                }
                setState(() {});
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
