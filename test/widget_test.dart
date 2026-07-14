import 'package:flutter_test/flutter_test.dart';

import 'package:countryscope/features/search/search_query.dart';

void main() {
  test('search normalization is case-insensitive and ignores whitespace', () {
    expect(normalizeSearchQuery(' India '), 'india');
  });
}
