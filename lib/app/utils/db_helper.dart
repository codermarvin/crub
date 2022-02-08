import 'package:crud/feature/models/contact.dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    Future<void> _createTableContacts(Database database) async {
      await database.execute(
          'CREATE TABLE contacts(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)');
    }

    return openDatabase(
      join(path, 'bookmarks.db'),
      onCreate: (Database database, int version) async {
        await _createTableContacts(database);
      },
      version: 1,
    );
  }

  Future<int> insertContact(Contact contact) async {
    final Database db = await initializeDB();
    return await db.insert('contacts', contact.toMap());
  }

  Future<void> updateContact(int id, Contact contact) async {
    final Database db = await initializeDB();
    await db.update('contacts', contact.toMap(),
        where: 'id = ?', whereArgs: <int>[id]);
  }

  Future<void> deleteContact(int id) async {
    final Database db = await initializeDB();
    await db.delete('contacts', where: 'id = ?', whereArgs: <int>[id]);
  }

  Future<List<Contact>> queryContacts() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> contacts = await db.query('contacts');
    return contacts
        .map((Map<String, dynamic> e) => Contact.fromMap(e))
        .toList();
  }

  Future<Contact> queryContactById(int id) async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> contacts =
        await db.query('contacts', where: 'id = ?', whereArgs: <int>[id]);
    return contacts.map((e) => Contact.fromMap(e)).first;
  }
}
