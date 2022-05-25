import 'package:flutter/material.dart';
import 'package:responsiveness/models/models.dart';

class SenderDetails extends StatelessWidget {
  const SenderDetails({
    Key? key,
    required this.sender,
  }) : super(key: key);

  final Sender sender;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sender.name,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          sender.email,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
