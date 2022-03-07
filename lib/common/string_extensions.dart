extension StringExtensions on String {
  String capitalize() =>
      '${this[0].toUpperCase()}${substring(1).toLowerCase()}';

  String removeJumpLines() => replaceAll('\n', ' ').replaceAll('\f', ' ');
}
