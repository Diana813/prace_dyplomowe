import 'package:prace_dyplomowe/db/db_service/DBRepository.dart';
import 'package:prace_dyplomowe/db/db_service/DbConnection.dart';

class DbHandler {
  showData(String command, DbRepository repo, DbConnection myConnection,
      [String? criteria1, String? criteria2]) {
    var response;
    switch (command) {
      case 'Wyświetl wszystkich studentów w kolejności alfabetycznej':
        response = repo.selectAllStudentsOrderedByLastName(myConnection);
        break;
      case 'Wyświetl wszystkich pracowników naukowych w kolejności alfabetycznej':
        response = repo.selectAllEployeesOrderedByLastName(myConnection);
        break;
      case 'Wyświetl wszystkie prace dyplomowe według tematu':
        response =
            repo.selectAllFinalThesisWhereTopic(myConnection, criteria1!);
        break;
      case 'Wyświetl wszystkie prace uporządkowane według rodzaju studiów':
        response = repo.selectFinalThesisByStudyType(myConnection, criteria1!);
        print('triggered');
        break;
      case 'Wyświetl wszystkie prace na podstawie słowa kluczowego':
        response = repo.selectFinalThesisByKeyWord(myConnection, criteria1!);
        break;
      case 'Wyświetl wszystkie prace i informacje o ich autorach':
        response = repo.selectAllFinalThesisWithAuthorInfo(myConnection);
        break;
      case 'Wyświetl wszystkie prace i informacje o ich promotorze':
        response = repo.selectAllFinalThesisWithPromotorInfo(myConnection);
        break;
      case 'Wyświetl pracę studenta o danym nazwisku':
        response = repo.selectFinalThesisByAuthorName(myConnection, criteria1!);
        break;
      case 'Wyświetl prace prowadzone przez danego promotora':
        response =
            repo.selectFinalThesisByPromotorName(myConnection, criteria1!);
        break;
    }
    return response;
  }
}
