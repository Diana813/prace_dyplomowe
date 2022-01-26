import 'package:prace_dyplomowe/db/db_service/DBRepository.dart';
import 'package:prace_dyplomowe/fragments/ModifyficationScreen.dart';
import 'package:prace_dyplomowe/fragments/SearchScreen.dart';

class InterfaceService {
  chooseFragmentToDisplay(bool modify, List<String> tables,
      DbRepository dbService, var connection, InterfaceService service) {
    if (modify) {
      return ModifyficationScreen(
        tables: tables,
        myConnection: connection,
        dbService: dbService,
        interfaceService: service,
      );
    } else {
      return SearchScreen(
        dbService: dbService,
        myConnection: connection,
        service: service,
      );
    }
  }

  filterSearchResults(String query, var tableData, Function showSearchedData,
      Function showAllData, String tableName) {
    var searchedData = [];
    if (tableData != null) {
      searchedData.addAll(tableData);
    }
    if (query.isNotEmpty) {
      var searchedTableData = [];
      searchedData.forEach((item) {
        if (item.toString().toLowerCase().contains(query.toLowerCase())) {
          searchedTableData.add(item);
        }
      });
      showSearchedData(searchedTableData);
      return;
    } else {
      showAllData(tableData);
    }
  }

  getDbCommands() {
    return [
      'Wyświetl wszystkich studentów w kolejności alfabetycznej',
      'Wyświetl wszystkich pracowników naukowych w kolejności alfabetycznej',
      'Wyświetl wszystkie prace dyplomowe według tematu',
      'Wyświetl wszystkie prace uporządkowane według rodzaju studiów',
      'Wyświetl wszystkie prace na podstawie słowa kluczowego',
      'Wyświetl wszystkie prace i informacje o ich autorach',
      'Wyświetl wszystkie prace i informacje o ich promotorze',
      'Wyświetl pracę studenta o danym nazwisku',
    ];
  }
}
