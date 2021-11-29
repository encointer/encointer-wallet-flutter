import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../0_main/BazaarMainState.dart';
import '../../menu/2_my_businesses/BusinessFormState.dart';
import '../../menu/camera/ImagePickerScaffold.dart';
import '../../shared/PhotoTiles.dart';
import '../../shared/ToggleButtonsWithTitle.dart';
import '../../shared/data_model/demo_data/DemoData.dart';
import '../2_my_businesses/BusinessFormState.dart';
import '../camera/ImagePickerScaffold.dart';
import 'OpeningHours.dart';

class BusinessFormScaffold extends StatelessWidget {
  var categories = allCategories; // TODO state management

  final BazaarMainState bazaarMainState;

  BusinessFormScaffold(this.bazaarMainState);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Business"),
      ),
      body: BusinessForm(bazaarMainState, categories: categories),
    );
  }
}

class BusinessForm extends StatelessWidget {
  BusinessForm(
    this.bazaarMainState, {
    @required this.categories,
  }) : businessFormState = bazaarMainState.bazaarMyBusinessesState.businessFormState;

  final BazaarMainState bazaarMainState;
  final List<String> categories; // TODO use state variable
  final BusinessFormState businessFormState;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: ListView(
          children: <Widget>[
            PhotoTiles(),
            LimitedBox(
              child: ImagePickerScaffold(bazaarMainState),
              maxHeight: 250,
            ),
            Observer(
              builder: (_) => TextField(
                onChanged: (value) => businessFormState.name = value,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Use a descriptive name',
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
                    labelText: 'Description',
                    hintText: 'Spark interest in your offering and provide a succinct description',
                    errorText: businessFormState.errors.description),
              ),
            ),

            ToggleButtonsWithTitle("Categories", categories, null),
            // TODO state mananagement
            BusinessAddress(bazaarMainState),
            Text(
              "Opening Hours",
              style: TextStyle(height: 2, fontWeight: FontWeight.bold),
            ),
            OpeningHours(bazaarMainState),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  child: Row(children: [Icon(Icons.delete), Text("Delete")]),
                  onPressed: () {
                    // TODO modify state
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Row(children: [Icon(Icons.check), Text("Save")]),
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
  final BazaarMainState bazaarMainState;

  BusinessAddress(this.bazaarMainState) : businessFormState = bazaarMainState.bazaarMyBusinessesState.businessFormState;

  final BusinessFormState businessFormState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Address", style: TextStyle(fontWeight: FontWeight.bold, height: 2.5)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Observer(
                builder: (_) => TextField(
                  onChanged: (value) => businessFormState.street = value,
                  decoration: InputDecoration(
                    labelText: 'Street',
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
                    labelText: 'No.',
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
                    labelText: 'ZIP code',
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
                    labelText: 'City',
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
