import 'package:prace_dyplomowe/db/db_service/DbConnection.dart';

class DbRepository {
  selectAll(String table, DbConnection myConnection) async {
    table = translateTableName(table);
    var connection = await myConnection.connectToDb();
    List<dynamic> items = [];
    var response;
    if (table == 'Praca_dyplomowa') {
      response = await connection.query('${showFinalThesis()} Order by Temat_pracy.Temat_pracy ASC');
    } else {
      response = await connection.query("SELECT * FROM $table");
    }

    response.forEach((row) {
      items.add(row);
    });
    myConnection.connectionClose(connection);
    return items;
  }

  deleteRecord(String table, DbConnection myConnection, int id) async {
    table = translateTableName(table);
    String tableId = 'id_$table';
    var connection = await myConnection.connectToDb();
    await connection.query("DELETE FROM $table WHERE $tableId  = $id");
    myConnection.connectionClose(connection);
  }

  insertRecord(
      String table, DbConnection myConnection, List<String> values) async {
    table = translateTableName(table);
    var connection = await myConnection.connectToDb();
    await connection.query("Insert into $table values ($values)");
    myConnection.connectionClose(connection);
  }

  updateRecord(String table, DbConnection myConnection, String column,
      String value, int id) async {
    table = translateTableName(table);
    var connection = await myConnection.connectToDb();
    await connection.query("Update $table set $column = $value where id = $id");
    myConnection.connectionClose(connection);
  }

  selectAllStudentsOrderedByLastName(DbConnection myConnection) async {
    var items = [];
    var connection = await myConnection.connectToDb();
    var response =
        await connection.query("SELECT * FROM Student ORDER BY Nazwisko ASC");
    response.forEach((row) {
      items.add(row);
    });
    myConnection.connectionClose(connection);
    return items;
  }

  selectAllEployeesOrderedByLastName(DbConnection myConnection) async {
    var items = [];
    var connection = await myConnection.connectToDb();
    var response = await connection.query(
        "SELECT Stopien_naukowy, Imie, Nazwisko FROM Pracownik_naukowy INNER JOIN Stopien_naukowy ON Pracownik_naukowy.id_Stopien_naukowy=Stopien_naukowy.id_Stopien_naukowy Order by Nazwisko ASC");
    response.forEach((row) {
      items.add(row);
    });
    myConnection.connectionClose(connection);
    return items;
  }

  selectAllFinalThesisWhereTopic(
      DbConnection myConnection, String orderCriteria1) async {
    var items = [];
    var connection = await myConnection.connectToDb();
    var response = await connection.query(
        "${showFinalThesis()} WHERE Temat_pracy.Temat_pracy = '$orderCriteria1'");
    response.forEach((row) {
      items.add(row);
    });
    myConnection.connectionClose(connection);
    return items;
  }

  selectFinalThesisByStudyType(
      DbConnection myConnection, String studyType) async {
    var items = [];
    var connection = await myConnection.connectToDb();
    var response = await connection.query(
        "${showFinalThesis()} Where Typ_studiow.Typ_studiow = '$studyType'");
    response.forEach((row) {
      items.add(row);
    });
    myConnection.connectionClose(connection);
    return items;
  }

  selectFinalThesisByKeyWord(DbConnection myConnection, String keyWord) async {
    List<dynamic> items = [];
    var connection = await myConnection.connectToDb();
    var response = await connection.query(
        "${showFinalThesis()} Where Slowo_kluczowe.Slowo_kluczowe = '$keyWord'");
    response.forEach((row) {
      items.add(row);
    });
    myConnection.connectionClose(connection);
    return items;
  }

  selectAllFinalThesisWithAuthorInfo(DbConnection myConnection) async {
    var items = [];
    var connection = await myConnection.connectToDb();
    var response = await connection.query(
        "SELECT Student.Id_Student, Student.imie, Student.nazwisko, Temat_pracy.Temat_pracy FROM Praca_dyplomowa "
        "join Autor on Autor.Id_Student = Praca_dyplomowa.Id_Autor "
        "join Student on Student.Id_Student = Autor.Id_Student "
        "join Temat_pracy on Temat_pracy.Id_Temat_pracy = Praca_dyplomowa.Id_Temat_pracy");
    response.forEach((row) {
      items.add(row);
    });
    myConnection.connectionClose(connection);
    return items;
  }

  selectAllFinalThesisWithPromotorInfo(DbConnection myConnection) async {
    var items = [];
    var connection = await myConnection.connectToDb();
    var response = await connection.query(
        "SELECT Stopien_naukowy.Stopien_naukowy, Pracownik_naukowy.Imie, Pracownik_naukowy.Nazwisko, Temat_pracy.Temat_pracy FROM Praca_dyplomowa "
        "join Pracownik_naukowy on Pracownik_naukowy.Id_Pracownik_naukowy = Praca_dyplomowa.Id_Promotor "
        "join Stopien_naukowy on Stopien_naukowy.Id_Stopien_naukowy = Pracownik_naukowy.Id_Stopien_naukowy "
        "join Temat_pracy on Temat_pracy.Id_Temat_pracy = Praca_dyplomowa.Id_Temat_pracy");
    response.forEach((row) {
      items.add(row);
    });
    myConnection.connectionClose(connection);
    return items;
  }


  selectFinalThesisByAuthorName(
      DbConnection myConnection, String orderCriteria1) async {
    var items = [];
    var connection = await myConnection.connectToDb();
    var response = await connection.query(
        "${showFinalThesis()} WHERE Student.nazwisko = '$orderCriteria1'");
    response.forEach((row) {
      items.add(row);
    });
    myConnection.connectionClose(connection);
    return items;
  }

  selectFinalThesisByPromotorName(
      DbConnection myConnection, String promotorName) async {
    List<dynamic> items = [];
    var connection = await myConnection.connectToDb();

    var response = await connection.query(
        "SELECT * FROM Prace_dyplomowe WHERE Promotor.Nazwisko = $promotorName INNER JOIN Pracownik_naukowy ON Pracownik_naukowy.Id_Pracownika_naukowego=Promotor.Id_Promotora");
    response.forEach((row) {
      items.add(row);
    });
    myConnection.connectionClose(connection);
    return items;
  }


  getListOfColumns(String tableName, DbConnection myConnection) async {
    tableName = translateTableName(tableName);
    var connection = await myConnection.connectToDb();
    var headers = await connection.query(
        "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = '$tableName' ORDER BY ORDINAL_POSITION");
    myConnection.connectionClose(connection);
    return headers;
  }


  translateTableName(String tableName) {
    String name = '';
    switch (tableName) {
      case 'Stopień naukowy':
        name = 'Stopien_naukowy';
        break;
      case 'Praca dyplomowa':
        name = 'Praca_dyplomowa';
        break;
      case 'Słowo kluczowe':
        name = 'Slowo_kluczowe';
        break;
      case 'Pracownik naukowy':
        name = 'Pracownik_naukowy';
        break;
      case 'Typ studiów':
        name = 'Typ_studiow';
        break;
      case 'Temat':
        name = 'Temat_pracy';
        break;
      case 'Ocena':
        name = 'Ocena';
        break;
      case 'Recenzja':
        name = 'Recenzja';
        break;
      case 'Student':
        name = 'Student';
        break;
      case 'Obrona':
        name = 'Obrona';
        break;
    }
    return name;
  }

  showFinalThesis() {
    return "SELECT Temat_pracy.Temat_pracy, "
        "Stopien_naukowy.Stopien_naukowy, Pracownik_naukowy.Imie, Pracownik_naukowy.Nazwisko,"
        "Stopien_naukowy.Stopien_naukowy, Pracownik_naukowy.Imie, Pracownik_naukowy.Nazwisko, Ocena.Ocena, "
        "Typ_studiow.Typ_Studiow,"
        "Autor.Id_Student, Ocena.Ocena, Obrona.Data_obrony, Student.Imie, Student.Nazwisko, "
        "Slowo_kluczowe.Slowo_kluczowe "
        "FROM Praca_dyplomowa "
        "join Temat_pracy on Temat_pracy.Id_Temat_pracy = Praca_dyplomowa.Id_Temat_pracy "
        "join Pracownik_naukowy on Pracownik_naukowy.Id_Pracownik_naukowy = Praca_dyplomowa.Id_Promotor "
        "join Stopien_naukowy on Stopien_naukowy.Id_Stopien_naukowy = Pracownik_naukowy.Id_Stopien_naukowy "
        "join Recenzja on Recenzja.Id_Recenzja = Praca_dyplomowa.Id_Recenzji "
        "join Ocena on Ocena.Id_Ocena = Recenzja.Id_Oceny "
        "join Pracownik_naukowy recenzent on recenzent.Id_Pracownik_naukowy = Recenzja.Id_Recenzenta "
        "join Stopien_naukowy stopien_recenzenta on stopien_recenzenta.Id_Stopien_naukowy = recenzent.Id_Stopien_naukowy "
        "join Typ_studiow on Typ_studiow.Id_Typ_studiow = Praca_dyplomowa.Id_Typ_studiow "
        "join Autor on Autor.Id_Student = Praca_dyplomowa.Id_Autor "
        "join Student on Student.Id_Student = Autor.Id_Student "
        "join Obrona on Obrona.Id_Obrona = Student.Id_Obrona "
        "join Ocena ocena_z_obrony on ocena_z_obrony.Id_Ocena = Obrona.Id_Ocena "
        "join Slowa_kluczowe on Slowa_kluczowe.Id_Slowa = Praca_dyplomowa.Id_Slowa "
        "join Slowo_kluczowe on Slowo_kluczowe.Id_Slowo_kluczowe = Slowa_kluczowe.Id_Slowa ";
  }
}
