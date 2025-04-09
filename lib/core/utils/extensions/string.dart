extension StringExt on String {
  String get firstName => split(' ').firstOrNull ?? '';

  String get initials {
    final names = split(' ');
    if (names.length == 1) {
      return names.first.substring(0, 1).toUpperCase();
    } else if (names.length > 1) {
      return '${names.first.substring(0, 1).toUpperCase()}${names.last.substring(0, 1).toUpperCase()}';
    }
    return '';
  }
}
