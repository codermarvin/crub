import 'package:crud/feature/models/contact.dto.dart';
import 'package:equatable/equatable.dart';

abstract class ContactListState extends Equatable {}

class ContactListInitialState extends ContactListState {
  @override
  List<Object> get props => <Object>[];
}

class GetContactListLoadingState extends ContactListState {
  @override
  List<Object> get props => <Object>[];
}

class GetContactListSuccessState extends ContactListState {
  GetContactListSuccessState({required this.contacts});
  final List<Contact> contacts;
  @override
  List<Object> get props => <Object>[];
}

class GetContactListFailedState extends ContactListState {
  GetContactListFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class GetContactLoadingState extends ContactListState {
  @override
  List<Object> get props => <Object>[];
}

class GetContactSuccessState extends ContactListState {
  GetContactSuccessState({required this.contact});
  final Contact contact;
  @override
  List<Object> get props => <Object>[];
}

class GetContactFailedState extends ContactListState {
  GetContactFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class AddContactLoadingState extends ContactListState {
  @override
  List<Object> get props => <Object>[];
}

class AddContactSuccessState extends ContactListState {
  AddContactSuccessState();
  @override
  List<Object> get props => <Object>[];
}

class AddContactFailedState extends ContactListState {
  AddContactFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class UpdateContactLoadingState extends ContactListState {
  @override
  List<Object> get props => <Object>[];
}

class UpdateContactSuccessState extends ContactListState {
  UpdateContactSuccessState();
  @override
  List<Object> get props => <Object>[];
}

class UpdateContactFailedState extends ContactListState {
  UpdateContactFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}

class RemoveContactLoadingState extends ContactListState {
  @override
  List<Object> get props => <Object>[];
}

class RemoveContactSuccessState extends ContactListState {
  RemoveContactSuccessState();
  @override
  List<Object> get props => <Object>[];
}

class RemoveContactFailedState extends ContactListState {
  RemoveContactFailedState({required this.error});
  final String error;
  @override
  List<Object> get props => <Object>[];
}
