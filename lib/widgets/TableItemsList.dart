import 'package:flutter/material.dart';
import 'package:prace_dyplomowe/utils/MyColors.dart';

class TableItamsList extends StatelessWidget {
  var items;
  Function deleteItem;
  bool visible;

  TableItamsList({required this.items, required this.deleteItem, required this.visible});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      child: ListView.builder(
          itemExtent: 75,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 10,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: items[index].length ?? 0,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              items[index].elementAt(i).toString(),
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          );
                        }),
                  ),
                  Flexible(
                    flex: 1,
                    child: Visibility(
                      visible: visible,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: MyColors.blue),
                        onPressed: (){},
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
