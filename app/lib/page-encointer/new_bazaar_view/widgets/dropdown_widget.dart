// import 'package:encointer_wallet/common/theme.dart';
import 'package:encointer_wallet/common/theme.dart';
import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  Category selectedCategory = Category.alle;

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    return DropdownMenu<Category>(
      initialSelection: Category.alle,
      dropdownMenuEntries: Category.values
          .map(
            (e) => DropdownMenuEntry<Category>(
              value: e,
              label: e.name,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          )
          .toList(),
      onSelected: (category) {
        setState(() {
          if (category != null) selectedCategory = category;
        });
      },
      inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFf4f7f8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          constraints: const BoxConstraints(maxHeight: 40)),
      trailingIcon: const Icon(
        Icons.keyboard_arrow_down_outlined,
        color: encointerGrey,
      ),
    );
  }
}

enum Category {
  alle,
  artAndMusic,
  bodyAndSoul,
  fashionAndClothing,
  foodAndBeverageStore,
  restaurantsAndBars,
  neuBeiLeu
}

extension CategoryEntry on Category {
  String get name {
    switch (this) {
      case Category.alle:
        return 'Alle';
      case Category.artAndMusic:
        return 'Art & Music';
      case Category.bodyAndSoul:
        return 'Body & Soul';
      case Category.fashionAndClothing:
        return 'Fashion and Clothing';
      case Category.foodAndBeverageStore:
        return 'Food & Beverage Store';
      case Category.restaurantsAndBars:
        return 'Restaurants & Bars';
      case Category.neuBeiLeu:
        return 'Neu bei Leu';
    }
  }

  bool get enabled => this != Category.neuBeiLeu;
}

// return Form(
    //   child: Column(
    //     children: [
    // DropdownButtonFormField<Category>(
    //   value: selectedCategory,
    //   items: Category.values.map((Category category) {
    //     return DropdownMenuItem<Category>(
    //       value: category,
    //       child: Text(category.label, style: textTheme.bodySmall),
    //     );
    //   }).toList(),
    //   onChanged: (Category? newValue) {
    //     setState(() {
    //       selectedCategory = newValue!;
    //     });
    //   },
    //   icon: const Icon(Icons.keyboard_arrow_down_outlined),
    //   iconEnabledColor: encointerGrey,
    //   decoration: InputDecoration(
    //     filled: true,
    //     fillColor: const Color(0xFFf4f7f8),
    //     border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(20),
    //       borderSide: BorderSide.none,
    //     ),
    //     isDense: false,
    //     contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
    //   ),
    //   dropdownColor: Colors.white,
    //   selectedItemBuilder: (BuildContext context) {
    //     return Category.values.map<Widget>((Category category) {
    //       return Center(
    //         child: Text(
    //           category.label,
    //           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
    //         ),
    //       );
    //     }).toList();
    //   },
    //   itemHeight: 50,
    // itemPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(10.0),
    //     color: Colors.grey[200],
    // ),
    //     ],
    //   ),
    // );

// import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownMenu]s. The first dropdown menu has an outlined border.

// void main() => runApp(const DropdownMenuExample());

// class DropdownMenuExample extends StatefulWidget {
//   const DropdownMenuExample({super.key});

//   @override
//   State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
// }

// class _DropdownMenuExampleState extends State<DropdownMenuExample> {
//   final TextEditingController colorController = TextEditingController();
//   final TextEditingController iconController = TextEditingController();
//   ColorLabel? selectedColor;
//   IconLabel? selectedIcon;

//   @override
//   Widget build(BuildContext context) {
//     final List<DropdownMenuEntry<ColorLabel>> colorEntries = <DropdownMenuEntry<ColorLabel>>[];
//     for (final ColorLabel color in ColorLabel.values) {
//       colorEntries.add(
//         DropdownMenuEntry<ColorLabel>(
//           value: color,
//           label: color.label,
//           enabled: color.label != 'Grey',
//         ),
//       );
//     }

//     final List<DropdownMenuEntry<IconLabel>> iconEntries = <DropdownMenuEntry<IconLabel>>[];
//     for (final IconLabel icon in IconLabel.values) {
//       iconEntries.add(DropdownMenuEntry<IconLabel>(value: icon, label: icon.label));
//     }

//     return MaterialApp(
//       theme: ThemeData(
//         useMaterial3: true,
//         colorSchemeSeed: Colors.green,
//       ),
//       home: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     DropdownMenu<ColorLabel>(
//                       initialSelection: ColorLabel.green,
//                       controller: colorController,
//                       label: const Text('Color'),
//                       dropdownMenuEntries: colorEntries,
//                       onSelected: (ColorLabel? color) {
//                         setState(() {
//                           selectedColor = color;
//                         });
//                       },
//                     ),
//                     const SizedBox(width: 20),
//                     DropdownMenu<IconLabel>(
//                       controller: iconController,
//                       enableFilter: true,
//                       leadingIcon: const Icon(Icons.search),
//                       label: const Text('Icon'),
//                       dropdownMenuEntries: iconEntries,
//                       inputDecorationTheme: const InputDecorationTheme(
//                         filled: true,
//                         contentPadding: EdgeInsets.symmetric(vertical: 5.0),
//                       ),
//                       onSelected: (IconLabel? icon) {
//                         setState(() {
//                           selectedIcon = icon;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//               ),
//               if (selectedColor != null && selectedIcon != null)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text('You selected a ${selectedColor?.label} ${selectedIcon?.label}'),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5),
//                       child: Icon(
//                         selectedIcon?.icon,
//                         color: selectedColor?.color,
//                       ),
//                     )
//                   ],
//                 )
//               else
//                 const Text('Please select a color and an icon.')
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// enum ColorLabel {
//   blue('Blue', Colors.blue),
//   pink('Pink', Colors.pink),
//   green('Green', Colors.green),
//   yellow('Yellow', Colors.yellow),
//   grey('Grey', Colors.grey);

//   const ColorLabel(this.label, this.color);
//   final String label;
//   final Color color;
// }

// enum IconLabel {
//   smile('Smile', Icons.sentiment_satisfied_outlined),
//   cloud(
//     'Cloud',
//     Icons.cloud_outlined,
//   ),
//   brush('Brush', Icons.brush_outlined),
//   heart('Heart', Icons.favorite);

//   const IconLabel(this.label, this.icon);
//   final String label;
//   final IconData icon;
// }
