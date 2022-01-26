import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prace_dyplomowe/brain/InterfaceService.dart';
import 'package:prace_dyplomowe/db/db_service/DBRepository.dart';
import 'package:prace_dyplomowe/db/db_service/DbConnection.dart';
import 'package:prace_dyplomowe/db/db_service/DbHandler.dart';
import 'package:prace_dyplomowe/widgets/MyDropdownButton.dart';
import 'package:prace_dyplomowe/widgets/MySearchTextField.dart';
import 'package:prace_dyplomowe/widgets/TableItemsList.dart';

class SearchScreen extends StatefulWidget {
  InterfaceService service;
  DbConnection myConnection;
  DbRepository dbService;

  SearchScreen(
      {required this.dbService,
      required this.myConnection,
      required this.service});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String choosenCommand;
  late List<String> commandList;
  late var connection;
  TextEditingController _textEditingController = TextEditingController();
  String textFieldString = '';
  DbHandler dbHandler = DbHandler();
  String? criteria1;
  String? criteria2;
  var tableItems = [];
  String TAG = "SearchScreen";

  @override
  void initState() {
    super.initState();
    commandList = widget.service.getDbCommands();
    choosenCommand = commandList.first;
    connection = widget.myConnection.connectToDb();
    getTableItems();
    _textEditingController.addListener(() {
      textFieldString = _textEditingController.text;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  getCriteria() {
    setState(() {
      if (textFieldString.isNotEmpty) {
        if (textFieldString.contains(',')) {
          criteria1 = textFieldString.split(',').first;
          criteria2 = textFieldString.split(',').last;
        } else {
          criteria1 = textFieldString;
        }
      }

    });

  }

  getTableItems() async {
    tableItems = await dbHandler.showData(choosenCommand, widget.dbService,
        widget.myConnection, criteria1, criteria2);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyDropdownButton(
                tables: commandList,
                dropdownValue: choosenCommand,
                onChange: (String? newValue) {
                  setState(() {
                    choosenCommand = newValue!;
                    getCriteria();
                    getTableItems();
                  });
                },
              ),
              Container(
                width: 600,
                height: 100,
                child: MySearchTextField(
                  submit:(value){
                    getCriteria();
                    getTableItems();
                  },
                  clearSearchResult: () {
                    _textEditingController.clear();
                    textFieldString = '';
                  },
                  textEditingController: _textEditingController,
                  label: 'Dodaj parametry wyszukiwania',
                  hint:
                      'Jeśli chcesz wpisać dwa parametry wyszukiwania, dodaj je po przecinku',
                ),
              ),
              TableItamsList(items: tableItems,deleteItem: (){}, visible: false),
            ],
          ),
        ),
      ),
    );
  }
}
