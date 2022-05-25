import 'package:flutter/material.dart';
import 'package:responsiveness/widgets/sender_avatar.dart';
import 'package:responsiveness/widgets/sender_details.dart';

import '../models/email.dart';
import 'email_delivery_info.dart';

class EmailHeader extends StatelessWidget {
  const EmailHeader({Key? key, required this.email}) : super(key: key);

  final Email email;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        FittedBox(
          child: Row(
            children: [
              FittedBox(
                child: SenderAvatar(
                  sender: email.sender,
                  radius: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(child: SenderDetails(sender: email.sender)),
              ),
            ],
          ),
        ),
        FittedBox(child: EmailDeliveryInfo(email: email)),
      ],
    );
  }
}
