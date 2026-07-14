abstract final class GraphqlQueries {
  static const countries = r'''
    query Countries {
      countries {
        code name native phone capital currency emoji emojiU
        continent { code name }
        languages { code name native rtl }
      }
    }
  ''';
}
