extension DateTimeFormatter on DateTime {
  String formatDateTime() {
    final diff = DateTime.now().difference(this);

    if (diff.inSeconds < 60) {
      return '${diff.inMinutes}s ago';
    }
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    }
    if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    }
    if (diff.inDays < 30) {
      return '${diff.inDays}d ago';
    }
    return '${diff.inDays ~/ 30}mo ago';
  }
}
