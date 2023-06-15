import 'package:encointer_wallet/common/components/gradient_elements.dart';
import 'package:encointer_wallet/gen/assets.gen.dart';
import 'package:encointer_wallet/modules/modules.dart';
import 'package:encointer_wallet/presentation/secure_account/stores/keep_your_phrase_safe_view_store.dart';
import 'package:encointer_wallet/presentation/secure_account/views/successfully_secured_seed_view.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/secure_account_title.dart';
import 'package:encointer_wallet/presentation/secure_account/widgets/seed_phrase_box.dart';
import 'package:encointer_wallet/store/app.dart';
import 'package:encointer_wallet/theme/custom/extension/theme_extension.dart';
import 'package:encointer_wallet/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class KeepYourPhraseSafeView extends StatefulWidget {
  const KeepYourPhraseSafeView({super.key});
  static const route = 'keep-your-phase-safe';

  @override
  // ignore: library_private_types_in_public_api
  _KeepYourPhraseSafeViewState createState() => _KeepYourPhraseSafeViewState();
}

class _KeepYourPhraseSafeViewState extends State<KeepYourPhraseSafeView> {
  late KeppYourPhraseSaveViewStore _store;

  @override
  void initState() {
    _store = KeppYourPhraseSaveViewStore(
      context.read<AppStore>(),
      context.read<NewAccountStore>(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keep your secret recovery phrase safe.'),
      ),
      body: Observer(
        builder: (_) {
          if (_store.loading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 40, left: 40, top: 40),
                      child: SecureAccountTitle(title: 'Keep your secret recovery phrase safe.'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Text(
                        "Here's your secret recovery phrase. Write them down on a piece of paper and keep it in a safe place..",
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorScheme.onBackground,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SeedPhraseBox(
                      phrase: _store.seed!,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
                          ),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: _store.seed!),
                          ).then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Successfully copied!')),
                            );
                          });
                        },
                        icon: Assets.encointerCopyIcons.svg(
                          colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.color),
                          width: 18,
                          height: 18,
                        ),
                        label: const Text('Copy recovery phrase'), // <-- Text
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith((s) => getColor(context, s)),
                            value: _store.isChecked,
                            onChanged: (bool? value) {
                              _store.setIsChecked();
                            },
                          ),
                          Expanded(
                            child: Text(
                              'I have written down the recovery phrase and kept it safe and understand that Encointer cannot assist me with an account recovery.',
                              style: context.textTheme.labelSmall!.copyWith(
                                color: context.colorScheme.onBackground.withOpacity(0.7),
                              ),
                              maxLines: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 28,
                        right: 28,
                        bottom: 60,
                        top: 20,
                      ),
                      child: PrimaryButton(
                        onPressed: () => _store.isChecked ? _onButtonClicked(context) : null,
                        backgroundGradient: _store.isChecked ? null : AppColors.primaryGradientLight(context),
                        child: Text(
                          'Complete',
                          style: context.textTheme.displaySmall!.copyWith(
                            color: context.colorScheme.background,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }

  void _onButtonClicked(BuildContext context) {
    Navigator.pushNamed(context, SuccesfullySecuredSeedView.route);
  }

  Color getColor(BuildContext context, Set<MaterialState> states) {
    const interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return context.colorScheme.onBackground;
    }
    return context.colorScheme.primary;
  }
}
