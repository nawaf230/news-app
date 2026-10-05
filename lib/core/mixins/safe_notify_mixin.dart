import 'package:flutter/cupertino.dart';

mixin SafeNotifyMixin on ChangeNotifier {
  bool isDispose = false;

  void safeNotify() {
    if (!isDispose) notifyListeners();
  }

  @override
  void dispose() {
    isDispose = true;
    super.dispose();
  }
}
