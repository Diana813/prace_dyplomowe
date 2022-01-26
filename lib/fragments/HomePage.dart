import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prace_dyplomowe/brain/InterfaceService.dart';
import 'package:prace_dyplomowe/db/db_service/DBRepository.dart';
import 'package:prace_dyplomowe/db/db_service/DbConnection.dart';
import 'package:prace_dyplomowe/db/db_service/DbHandler.dart';
import 'package:prace_dyplomowe/db/model/Tables.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool modifyClicked = false;
  InterfaceService _service = InterfaceService();
  Tables tablesList = Tables();
  DbRepository dbServise = DbRepository();
  DbConnection myConnection = DbConnection();
  late var connection;
  late List<String> tables;

  @override
  void initState() {
    super.initState();
    tables = tablesList.tables;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Prace dyplomowe PW",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (modifyClicked) {
                        setState(() {
                          modifyClicked = false;
                        });
                      }
                    },
                    child: Text('Wyszukaj'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (modifyClicked == false) {
                        setState(() {
                          modifyClicked = true;
                        });
                      }
                    },
                    child: Text('Modyfikuj dane'),
                  ),
                )
              ],
            ),
          ),
          _service.chooseFragmentToDisplay(
              modifyClicked, tables, dbServise, myConnection, _service)
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
