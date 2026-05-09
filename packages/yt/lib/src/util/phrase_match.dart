import 'package:stemmer/stemmer.dart';
import 'package:yt/yt.dart';

class PhraseMatch {
  final _stemmer = PorterStemmer();

  final _wordSplitter = RegExp(r'[^a-zA-Z0-9_\+\-/]');

  final stopWords = [
    'a',
    'an',
    'any',
    'can',
    'for',
    'i',
    'if',
    'it',
    'its',
    'it\'s',
    'is',
    'in',
    'just',
    'may',
    'on',
    'this',
    'there',
    'the',
    'to',
    'we',
    'yes',
  ];

  bool checkQuestion({required String question, required Keyword keyword}) {
    List<List<String>> stemmedKeywords = [];

    keyword.patterns.cast<List<dynamic>>().forEach(
      (element) => stemmedKeywords.add(
        element.map((word) => _stemmer.stem(word.toString())).toList(),
      ),
    );

    final questionListStemmed = question
        .split(_wordSplitter)
        .where((word) => !stopWords.contains(word))
        .map((word) => _stemmer.stem(word))
        .toList();

    var entryScore = questionListStemmed.length;

    for (List<String> keywordList in stemmedKeywords) {
      questionListStemmed.removeWhere((word) => keywordList.contains(word));
    }

    return entryScore - questionListStemmed.length >= keyword.score;
  }
}
