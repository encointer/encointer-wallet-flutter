import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:flutter/material.dart';

class SeedPhraseBox extends StatelessWidget {
  const SeedPhraseBox({
    required this.phrase,
    super.key,
  });

  final String phrase;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: const TextStyle(),
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colorScheme.primary.withOpacity(0.2),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: _body(context),
          ),
        ),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      child: _generateSeedPhrase(context),
    );
  }

  Widget _generateSeedPhrase(BuildContext context) {
    final words = phrase.split(' ');

    final wordsStyle = context.textTheme.labelMedium?.copyWith(
      color: context.colorScheme.primary,
      height: 0.3,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: '',
        children: <TextSpan>[
          ...() {
            final newList = <TextSpan>[];
            for (var i = 0; i < words.length; i++) {
              if (i == words.length / 2) {
                newList.add(TextSpan(text: '\n', style: wordsStyle));
              }
              newList.add(TextSpan(text: words[i], style: wordsStyle));
              //todo change if seed phrase length != 12 or 24
              if (i != 5 && i != 11 && i != 23) {
                newList.add(const TextSpan(text: ' '));
              }
            }
            return newList;
          }(),
        ],
      ),
    );
  }
}
