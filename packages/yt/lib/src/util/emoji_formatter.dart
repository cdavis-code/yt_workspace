class EmojiFormatter {
  static final Map<String, String> emojiMap = {
    ':robot:': '🤖',
    ':mosque:': '🕌',
    ':video_camera:': '📹',
    ':growing_heart:': '💗',
  };

  static final regExp = RegExp('(:[a-zA-Z_]+:)');

  static String format(String data) =>
      data.replaceAllMapped(regExp, (match) => '${emojiMap[match[1]]}');
}
