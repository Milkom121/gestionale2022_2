import 'package:flutter/material.dart';

class MultiSelectionButtons extends StatefulWidget {
  MultiSelectionButtons(
      {Key? key,
      required this.titles,
      required this.references,
      required this.useTheChoice})
      : super(key: key);

  final List<String> titles;
  final List<Map<String, dynamic>> references;
  Function useTheChoice;

  @override
  State<MultiSelectionButtons> createState() => _MultiSelectionButtonsState();
}

class _MultiSelectionButtonsState extends State<MultiSelectionButtons> {
  int currentSelection = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (String title in widget.titles) {
      list.add(
        ElevatedButton(
          child: Text(title),
          style: ButtonStyle(
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            backgroundColor: MaterialStateProperty.all(
                widget.titles.indexOf(title) == currentSelection
                    ? Colors.blue
                    : Colors.transparent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: const BorderSide(color: Colors.transparent),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              currentSelection = widget.titles.indexOf(title);
              widget.useTheChoice;
            });
          },
         ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: list,
    );
  }
}

// import 'package:flutter/material.dart';
//
// class MultiSelectionButtons extends StatefulWidget {
//   const MultiSelectionButtons({Key? key, required this.titles})
//       : super(key: key);
//
//   final List titles;
//
//   @override
//   State<MultiSelectionButtons> createState() => _MultiSelectionButtonsState();
// }
//
// class _MultiSelectionButtonsState extends State<MultiSelectionButtons> {
//   int currentSelection = 0;
//
//   List<Widget> buttonsList() {
//     List<Widget> list = [];
//     for (String title in widget.titles) {
//
//       list.add(
//         ElevatedButton(
//           child: Text(title),
//           style:
//           ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(
//                   widget.titles.indexOf(title) == currentSelection
//                       ? Colors.blue
//                       : Colors.transparent),
//               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(18.0),
//                       side: const BorderSide(color: Colors.transparent)))),
//           onPressed: () {
//             setState(() {
//               currentSelection = widget.titles.indexOf(title);
//
//             });
//           },
//         ),
//       );
//     }
//     ;
//     return list;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: buttonsList(),
//     );
//   }
// }
