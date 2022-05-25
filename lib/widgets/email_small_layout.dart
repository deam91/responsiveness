import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data.dart';
import '../models/email.dart';
import '../notifiers/email_change_notifier.dart';
import 'email_delivery_info.dart';
import 'email_details.dart';
import 'email_preview.dart';
import 'sender_avatar.dart';

class EmailSmallLayout extends StatefulWidget {
  const EmailSmallLayout({
    Key? key,
  }) : super(key: key);

  @override
  State<EmailSmallLayout> createState() => _EmailSmallLayoutState();
}

class _EmailSmallLayoutState extends State<EmailSmallLayout> {
  final List<Email> emailList = [];

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  _buildEmails() {
    var future = Future(() {});
    for (var i = 0; i < emails.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 75), () {
          emailList.add(emails[i]);
          _listKey.currentState?.insertItem(emailList.length - 1);
        });
      });
    }
  }

  @override
  initState() {
    _buildEmails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      initialItemCount: emailList.length,
      itemBuilder: (context, index, animation) {
        final email = emailList[index];
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            curve: Curves.easeOutBack,
            parent: animation,
          )),
          child: InkWell(
            onTap: () {
              Provider.of<EmailChangeNotifier>(context, listen: false)
                  .setSelectedEmail(email);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EmailDetails(email: email),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  SenderAvatar(sender: email.sender),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EmailPreview(email: email),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      EmailDeliveryInfo(email: email),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.star_border),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
