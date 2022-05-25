import 'package:flutter/material.dart';
import 'package:responsiveness/models/models.dart';
import 'package:responsiveness/widgets/widgets.dart';

class EmailDetails extends StatelessWidget {
  const EmailDetails({
    Key? key,
    required this.email,
    this.onPin,
    this.pinned = false,
  }) : super(key: key);

  final Email email;
  final Function()? onPin;
  final bool pinned;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pinned ? Colors.orange.withOpacity(.12) : Colors.white,
        actions: [
          IconButton(
            onPressed: onPin,
            icon: pinned
                ? const Icon(
                    Icons.star_sharp,
                    color: Colors.orange,
                  )
                : const Icon(Icons.star_border),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SenderAvatar(
                  sender: email.sender,
                  radius: 30.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SenderDetails(sender: email.sender),
                  ),
                ),
                EmailDeliveryInfo(email: email),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                email.subject,
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    email.body,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
