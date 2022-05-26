import 'package:flutter/material.dart';
import 'package:theidioms/presentation/widgets/quiz_item_widget.dart';

class DragTargetWidget extends StatelessWidget {
  final String? text;
  final Function(String)? onAccept;

  const DragTargetWidget({Key? key, this.text, this.onAccept}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (
        BuildContext context,
        List<dynamic> accepted,
        List<dynamic> rejected,
      ) {
        return QuizItem(text: text!, color: Colors.grey.shade400);
      },
      onAccept: onAccept,
    );
  }
}
