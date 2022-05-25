import 'package:flutter/material.dart';
import 'package:responsiveness/models/email.dart';

class EmailChangeNotifier extends ChangeNotifier {
  Email? _selectedEmail = null;
  Email? _pinnedEmail = null;

  Email? get selectedEmail => _selectedEmail;
  Email? get pinnedEmail => _pinnedEmail;

  void setSelectedEmail(Email? email) {
    _selectedEmail = email;
    notifyListeners();
  }

  void setPinnedEmail(Email? email) {
    if (_pinnedEmail == email) {
      _pinnedEmail = null;
    } else {
      _pinnedEmail = email;
    }
    notifyListeners();
  }
}
