import 'package:flutter/material.dart';

class ItemSearch extends StatefulWidget {
  const ItemSearch(this.appTheme, this.btnStyle, this.menuItemStyle, this.onSearch, {super.key});
  final ThemeData appTheme;
  final ButtonStyle btnStyle;
  final ButtonStyle menuItemStyle;
  final Function(String) onSearch;

  @override
  State<StatefulWidget> createState() => _ItemSearchState();

}

class _ItemSearchState extends State<ItemSearch> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 20,),
        SizedBox(
          width: 300,
          height: 40,
          child: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Search by concept',
              alignLabelWithHint: true,
              counterText: "",
            ),
            maxLength: 30,
            autofocus: true,
            controller: searchController,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSearch(searchController.text);
          },
          child: const Text('Search'),
        ),
        ElevatedButton(
          onPressed: () {
            searchController.clear();
            widget.onSearch(searchController.text);
          },
          child: const Text('Clear'),
        ),
      ],
    );
  }

}