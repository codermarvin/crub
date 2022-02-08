import 'package:crud/app/utils/db_helper.dart';
import 'package:crud/feature/contacts/models/contact.dto.dart';
import 'package:crud/feature/contacts/presentation/bloc/contact_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactListBloc extends Cubit<ContactListState> {
  ContactListBloc() : super(ContactListInitialState());

  DatabaseHelper dbHelper = DatabaseHelper();

  void getList() async {
    emit(GetContactListLoadingState());
    try {
      await dbHelper.initializeDB().then((_) async {
        List<Contact> contacts = await dbHelper.queryContacts();
        contacts.sort((Contact a, Contact b) => a.name!.compareTo(b.name!));
        emit(GetContactListSuccessState(contacts: contacts));
      });
    } catch (e) {
      emit(GetContactListFailedState(error: e.toString()));
    }
  }

  void getById(int id) async {
    emit(GetContactLoadingState());
    try {
      await dbHelper.initializeDB().then((_) async {
        Contact contact = await dbHelper.queryContactById(id);
        emit(GetContactSuccessState(contact: contact));
      });
    } catch (e) {
      emit(GetContactFailedState(error: e.toString()));
    }
  }

  void add(Contact contact) async {
    emit(AddContactLoadingState());
    try {
      await dbHelper.initializeDB().then((_) async {
        await dbHelper.insertContact(contact);
        emit(AddContactSuccessState());
      });
    } catch (e) {
      emit(AddContactFailedState(error: e.toString()));
    }
  }

  void update(int id, Contact contact) async {
    emit(UpdateContactLoadingState());
    try {
      await dbHelper.initializeDB().then((_) async {
        await dbHelper.updateContact(id, contact);
        emit(UpdateContactSuccessState());
      });
    } catch (e) {
      emit(UpdateContactFailedState(error: e.toString()));
    }
  }

  void remove(int id) async {
    emit(RemoveContactLoadingState());
    try {
      await dbHelper.initializeDB().then((_) async {
        await dbHelper.deleteContact(id);
        emit(RemoveContactSuccessState());
      });
    } catch (e) {
      emit(RemoveContactFailedState(error: e.toString()));
    }
  }
}
