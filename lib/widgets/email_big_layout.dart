import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsiveness/data.dart';
import 'package:responsiveness/models/email.dart';
import 'package:responsiveness/notifiers/email_change_notifier.dart';
import 'package:responsiveness/widgets/widgets.dart';

class EmailBigLayout extends StatefulWidget {
  const EmailBigLayout({
    Key? key,
    required this.constraints,
  }) : super(key: key);

  final BoxConstraints constraints;

  @override
  State<EmailBigLayout> createState() => _EmailBigLayoutState();
}

class _EmailBigLayoutState extends State<EmailBigLayout> {
  final List<Email> emailList = [];
  final EmailChangeNotifier _controller = EmailChangeNotifier();
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
  didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(' -> build big layout');
    final left = widget.constraints.maxWidth > 1024
        ? widget.constraints.maxWidth / 3
        : widget.constraints.maxWidth / 2.5;
    return Row(
      children: [
        SizedBox(
          width: left,
          child: AnimatedList(
            key: _listKey,
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
                    _controller.setSelectedEmail(email);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0, right: 5.0),
                    child: Row(
                      children: [
                        SenderAvatar(sender: email.sender, radius: 50),
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
                            Consumer<EmailChangeNotifier>(
                              builder: (context, value, child) {
                                return IconButton(
                                  onPressed: () {
                                    _controller.setPinnedEmail(email);
                                    setState(() {});
                                  },
                                  icon: _controller.pinnedEmail == email
                                      ? const Icon(
                                          Icons.star_outlined,
                                          color: Colors.orange,
                                        )
                                      : const Icon(Icons.star_border),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, Widget? child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (_controller.pinnedEmail != null &&
                      _controller.pinnedEmail != _controller.selectedEmail!)
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: EmailDetails(
                          pinned: true,
                          onPin: () {
                            _controller.setPinnedEmail(null);
                          },
                          key: ValueKey(_controller.pinnedEmail),
                          email: _controller.pinnedEmail!,
                        ),
                      ),
                    ),
                  if (_controller.selectedEmail != null)
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        child: EmailDetails(
                          onPin: () {
                            _controller
                                .setPinnedEmail(_controller.selectedEmail!);
                            setState(() {});
                          },
                          pinned: _controller.pinnedEmail ==
                              _controller.selectedEmail!,
                          key: ValueKey(_controller.selectedEmail),
                          email: _controller.selectedEmail!,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
