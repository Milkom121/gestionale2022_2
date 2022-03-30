// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
//
// class ChoiseChipCustom extends StatefulWidget {
//    ChoiseChipCustom({Key? key, required this.onChanged}) : super(key: key) {
//      // TODO: implement
//      throw UnimplementedError();
//    }
//
//   final Function onChanged;
//
//   @override
//   State<ChoiseChipCustom> createState() => _ChoiseChipCustomState();
// }
//
// class _ChoiseChipCustomState extends State<ChoiseChipCustom> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(child: Icon(Icons.))
//         Expanded(
//           child: FormBuilderChoiceChip<dynamic>(
//             decoration: const InputDecoration(label: Text('Choose day slot')),
//             spacing: 5,
//             backgroundColor:Colors.blue[100], ,
//             selectedColor: Colors.blue,
//             name: 'day_slot',
//             initialValue: 8,
//             options: const [
//               FormBuilderFieldOption(value: 'entire'),
//               FormBuilderFieldOption(value: 'half'),
//               FormBuilderFieldOption(value: 'late'),
//             ],
//             onChanged:(value) {
//               widget.onChanged;
//             }
//           ),
//         ),
//       ],
//     );
//   }
// }
