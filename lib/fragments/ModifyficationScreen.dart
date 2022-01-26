import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prace_dyplomowe/brain/InterfaceService.dart';
import 'package:prace_dyplomowe/db/db_service/DBRepository.dart';
import 'package:prace_dyplomowe/db/db_service/DbConnection.dart';
import 'package:prace_dyplomowe/widgets/MyDropdownButton.dart';
import 'package:prace_dyplomowe/widgets/MySearchTextField.dart';
import 'package:prace_dyplomowe/widgets/TableItemsList.dart';

class ModifyficationScreen extends StatefulWidget {
  List<String> tables;
  DbRepository dbService;
  DbConnection myConnection;
  InterfaceService interfaceService;

  ModifyficationScreen(
      {required this.tables,
      required this.myConnection,
      required this.dbService,
      required this.interfaceService});

  @override
  State<ModifyficationScreen> createState() => _ModifyficationScreenState();
}

class _ModifyficationScreenState extends State<ModifyficationScreen> {
  late String choosenTable;
  final textEditingController = TextEditingController();
  late List<dynamic?> columnNames = [];
  var items = [];
  var tables = [];
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    choosenTable = widget.tables.first;
    getColumnNames(choosenTable);
    getData(choosenTable);
    textEditingController.addListener(() {
      filterResults(tables);
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  filterResults(var data) async {
    if (data != null) {
      var list = widget.interfaceService.filterSearchResults(
          textEditingController.text,
          tables,
          showSearchedData,
          showAllData,
          choosenTable);
      if (list != null) {
        items = list;
      }
    }
  }

  showSearchedData(var searchedTableData) {
    setState(() {
      items.clear();
      items.addAll(searchedTableData);
    });
  }

  showAllData(var tableData) {
    setState(() {
      if (tableData != null) {
        items.clear();
        items.addAll(tableData);
      }
    });
  }

  getColumnNames(String choosenTable) async {
    var columns = await widget.dbService
        .getListOfColumns(choosenTable, widget.myConnection);
    var data = [];
    columns.forEach((item) {
      data.add(item
          .toString()
          .replaceAll('Fields: {COLUMN_NAME: ', '')
          .replaceAll('}', ''));
    });
    setState(() {
      if (data != null) {
        columnNames = data;
      }
    });
  }

  getData(String choosenTable) async {
    var data =
        await widget.dbService.selectAll(choosenTable, widget.myConnection);
    setState(() {
      if (data != null) {
        tables = data;
      }
    });
    showAllData(tables);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Wybierz tabelę, którą chcesz modyfikować',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              MyDropdownButton(
                tables: widget.tables,
                dropdownValue: choosenTable,
                onChange: (String? newValue) {
                  choosenTable = newValue!;
                  getColumnNames(choosenTable);
                  getData(choosenTable);
                },
              ),
              Table(
                children: [
                  TableRow(children: [
                    Container(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: columnNames.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  columnNames.elementAt(index) ?? '',
                                  style: Theme.of(context).textTheme.subtitle1,
                                ),
                              ),
                            );
                          }),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      height: 50,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: columnNames.length,
                          itemBuilder: (context, index) {
                            return const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: SizedBox(
                                  width: 150, height: 50, child: TextField()),
                            );
                          }),
                    ),
                  ])
                ],
              ),
              MySearchTextField(
                submit: () {},
                textEditingController: textEditingController,
                clearSearchResult: () {
                  textEditingController.clear();
                  setState(() {
                    items.clear();
                    items.addAll(tables);
                  });
                },
                hint: 'Zacznij wpisywać',
                label: 'Szukaj',
              ),
              TableItamsList(
                items: items,
                deleteItem: (id) {
                  widget.dbService
                      .deleteRecord(choosenTable, widget.myConnection, id);
                },
                visible: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
