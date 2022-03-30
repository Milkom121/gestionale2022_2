import 'package:count_stepper/count_stepper.dart';
import 'package:flutter/material.dart';

class IncDecWidget extends StatefulWidget {
  IncDecWidget({Key? key, required this.onChanged, required this.icon, required this.title }) : super(key: key);

  final Function onChanged;
  Icon icon;
  Text title;

  @override
  State<IncDecWidget> createState() => _IncDecWidgetState();
}

class _IncDecWidgetState extends State<IncDecWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget.icon,
            const SizedBox(width: 15),
            widget.title,
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 42.0),
          child: CountStepper(
            iconColor: Theme.of(context).primaryColor,
            defaultValue: 0,
            // max: 100,
            min: 0,
            iconDecrementColor: Colors.red,
            iconIncrementColor: Colors.green,
            splashRadius: 30,
            onPressed: (value) {
              //TODO:aggiungere logica per inserire i lettini nella lista di elementi selezionati per la prenotazione. Per ora ho aggiunto un foor loop ma non va bene, forse sarà meglio usare un controller per questo CountStepper

              widget.onChanged(value); //TODO capire bene  come funziona questa cosa


            },
          ),
        ),
      ],
    );
  }
}
