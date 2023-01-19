import 'package:ew_translations/translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/business_form_state.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/2_my_businesses/opening_hours.dart';
import 'package:encointer_wallet/page-encointer/bazaar/menu/camera/image_picker_scaffold.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/data_model/demo_data/demo_data.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/photo_tiles.dart';
import 'package:encointer_wallet/page-encointer/bazaar/shared/toggle_buttons_with_title.dart';

class BusinessFormScaffold extends StatelessWidget {
  BusinessFormScaffold({super.key}); // TODO state management

  final categories = allCategories;

  @override
  Widget build(BuildContext context) => Provider<BusinessFormState>(
        create: (_) => BusinessFormState(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(context.dic.bazaar.businessAdd),
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
    final dic = context.dic;
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
                  hintText: dic.bazaar.businessNameHint,
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
                    labelText: dic.bazaar.description,
                    hintText: dic.bazaar.businessDescriptionHint,
                    errorText: businessFormState.errors.description),
              ),
            ),

            ToggleButtonsWithTitle(dic.bazaar.categories, categories, null),
            // TODO state mananagement
            const BusinessAddress(),
            Text(
              dic.bazaar.openningHours,
              style: const TextStyle(height: 2, fontWeight: FontWeight.bold),
            ),
            const OpeningHours(),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Row(children: [const Icon(Icons.delete), Text(dic.bazaar.delete)]),
                  onPressed: () {
                    // TODO modify state
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  onPressed: businessFormState.validateAll,
                  child: Row(children: [
                    const Icon(Icons.check),
                    Text(dic.bazaar.save),
                  ]),
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
    final dic = context.dic;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dic.bazaar.address,
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
                    labelText: dic.bazaar.street,
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
                    labelText: dic.bazaar.zipCode,
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
                    labelText: dic.bazaar.city,
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
