extension StringExt on String {
  String get firstName {
    if (isEmpty) return '';
    return split(' ').firstOrNull ?? '';
  }

  String get initials {
    if (isEmpty) {
      return '';
    } else {
      final names = split(' ');
      if (names.length == 1) {
        return names.first.substring(0, 1).toUpperCase();
      } else {
        return '${names.first.substring(0, 1).toUpperCase()}'
            '${names.last.substring(0, 1).toUpperCase()}';
      }
    }
  }
}
