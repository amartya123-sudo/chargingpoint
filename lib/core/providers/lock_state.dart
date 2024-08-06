import 'package:flutter/foundation.dart';

class LockState with ChangeNotifier {
  bool _isLocked = false;

  bool get isLocked => _isLocked;

  void setLocked(bool locked) {
    _isLocked = locked;
    notifyListeners();
  }
} 