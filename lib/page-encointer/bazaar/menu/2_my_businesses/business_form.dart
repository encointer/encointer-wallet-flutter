import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/business_form_state.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/camera/image_picker_scaffold.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/photo_tiles.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';
import 'package:encointer_wallet/utils/translations/index.dart';
import 'package:encointer_wallet/utils/translations/translations.dart';

import 'opening_hours.dart';

class BusinessFormScaffold extends StatelessWidget {
  final categories = allCategories; // TODO state management

  @override
  Widget build(BuildContext context) => Provider<BusinessFormState>(
        create: (_) => BusinessFormState(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(I18n.of(context)!.translationsForLocale().bazaar.businessAdd),
          ),
          body: BusinessForm(categories: categories),
        ),
      );
}

class BusinessForm extends StatelessWidget {
  const BusinessForm({
    required this.categories,
  });

  final List<String> categories;

  @override
  Widget build(BuildContext context) {
    final businessFormState = Provider.of<BusinessFormState>(context);
    return Form(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: <Widget>[
            PhotoTiles(),
            LimitedBox(
              child: ImagePickerScaffold(),
              maxHeight: 250,
            ),
            Observer(
              builder: (_) => TextField(
                onChanged: (value) => businessFormState.name = value,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: I18n.of(context)!.translationsForLocale().bazaar.businessNameHint,
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
                    labelText: I18n.of(context)!.translationsForLocale().bazaar.description,
                    hintText: I18n.of(context)!.translationsForLocale().bazaar.businessDescriptionHint,
                    errorText: businessFormState.errors.description),
              ),
            ),

            ToggleButtonsWithTitle(I18n.of(context)!.translationsForLocale().bazaar.categories, categories, null),
            // TODO state mananagement
            BusinessAddress(),
            Text(
              I18n.of(context)!.translationsForLocale().bazaar.openningHours,
              style: TextStyle(height: 2, fontWeight: FontWeight.bold),
            ),
            OpeningHours(),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Row(
                      children: [Icon(Icons.delete), Text(I18n.of(context)!.translationsForLocale().bazaar.delete)]),
                  onPressed: () {
                    // TODO modify state
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child:
                      Row(children: [Icon(Icons.check), Text(I18n.of(context)!.translationsForLocale().bazaar.save)]),
                  onPressed: () {
                    businessFormState.validateAll();
                    // TODO pop if valid
                    // Navigator.pop(context);
                  },
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
  const BusinessAddress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Translations dic = I18n.of(context)!.translationsForLocale();
    final businessFormState = Provider.of<BusinessFormState>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          I18n.of(context)!.translationsForLocale().bazaar.address,
          style: TextStyle(fontWeight: FontWeight.bold, height: 2.5),
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
                    labelText: I18n.of(context)!.translationsForLocale().bazaar.street,
                    errorText: businessFormState.errors.street,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              child: Observer(
                builder: (_) => TextField(
                  onChanged: (value) => businessFormState.streetAddendum = value,
                  decoration: InputDecoration(
                    labelText: dic.bazaar.no,
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
                    labelText: I18n.of(context)!.translationsForLocale().bazaar.zipCode,
                    errorText: businessFormState.errors.zipCode,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 32,
            ),
            Expanded(
              flex: 2,
              child: Observer(
                builder: (_) => TextField(
                  onChanged: (value) => businessFormState.city = value,
                  decoration: InputDecoration(
                    labelText: I18n.of(context)!.translationsForLocale().bazaar.city,
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
