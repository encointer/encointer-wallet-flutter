import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/business_form_state.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/opening_hours.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/camera/image_picker_scaffold.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/photo_tiles.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';
import 'package:encointer_wallet/l10n/l10.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class BusinessFormScaffold extends StatelessWidget {
  BusinessFormScaffold({super.key}); // TODO state management

  final categories = allCategories;

  @override
  Widget build(BuildContext context) => Provider<BusinessFormState>(
        create: (_) => BusinessFormState(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.l10n.businessAdd),
          ),
          body: BusinessForm(categories: categories),
        ),
      );
}

class BusinessForm extends StatelessWidget {
  const BusinessForm({super.key, required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    final businessFormState = Provider.of<BusinessFormState>(context);
    return Form(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: <Widget>[
            const PhotoTiles(),
            LimitedBox(
              maxHeight: 250,
              child: ImagePickerScaffold(),
            ),
            Observer(
              builder: (_) => TextField(
                onChanged: (value) => businessFormState.name = value,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: context.l10n.businessNameHint,
                  errorText: businessFormState.errors.name,
                ),
              ),
            ),

            Observer(
              builder: (_) => TextField(
                // keyboardType: TextInputType.multiline,
                // maxLines: 3,
                onChanged: (value) => businessFormState.description = value,
                decoration: InputDecoration(
                    labelText: context.l10n.description,
                    hintText: context.l10n.businessDescriptionHint,
                    errorText: businessFormState.errors.description),
              ),
            ),

            ToggleButtonsWithTitle(context.l10n.categories, categories, null),
            // TODO state mananagement
            const BusinessAddress(),
            Text(
              context.l10n.openningHours,
              style: const TextStyle(height: 2, fontWeight: FontWeight.bold),
            ),
            const OpeningHours(),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Row(children: [const Icon(Icons.delete), Text(context.l10n.delete)]),
                  onPressed: () {
                    // TODO modify state
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  onPressed: businessFormState.validateAll,
                  child: Row(children: [const Icon(Icons.check), Text(context.l10n.save)]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BusinessAddress extends StatelessWidget {
  const BusinessAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final businessFormState = Provider.of<BusinessFormState>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.address,
          style: const TextStyle(fontWeight: FontWeight.bold, height: 2.5),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Observer(
                builder: (_) => TextField(
                  onChanged: (value) => businessFormState.street = value,
                  decoration: InputDecoration(
                    labelText: context.l10n.street,
                    errorText: businessFormState.errors.street,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Expanded(
              child: Observer(
                builder: (_) => TextField(
                  onChanged: (value) => businessFormState.streetAddendum = value,
                  decoration: InputDecoration(
                    labelText: context.l10n.no,
                    errorText: businessFormState.errors.streetAddendum,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Observer(
                builder: (_) => TextField(
                  onChanged: (value) => businessFormState.zipCode = value,
                  decoration: InputDecoration(
                    labelText: context.l10n.zipCode,
                    errorText: businessFormState.errors.zipCode,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Expanded(
              flex: 2,
              child: Observer(
                builder: (_) => TextField(
                  onChanged: (value) => businessFormState.city = value,
                  decoration: InputDecoration(
                    labelText: context.l10n.city,
                    errorText: businessFormState.errors.city,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
