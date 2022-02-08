import 'package:crud/feature/models/contact.dto.dart';
import 'package:crud/feature/presentation/bloc/contact_list_bloc.dart';
import 'package:crud/feature/presentation/bloc/contact_list_state.dart';
import 'package:crud/feature/presentation/screen/sub/add_contact_screen.dart';
import 'package:crud/feature/presentation/screen/sub/edit_contact_screen.dart';
import 'package:crud/widgets/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  late ContactListBloc contactListBloc;
  List<Contact> contacts = <Contact>[];

  @override
  void initState() {
    contactListBloc = BlocProvider.of<ContactListBloc>(context);
    contactListBloc.getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(AddContactScreen.route())
                    .then((_) => contactListBloc.getList());
              },
              icon: const Icon(Icons.add)),
        ],
      ),
      body: BlocBuilder<ContactListBloc, ContactListState>(
          builder: (BuildContext context, ContactListState state) {
        if (state is GetContactListLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetContactListSuccessState) {
          contacts = state.contacts;
        }
        if (state is GetContactListFailedState) {
          return Center(child: Text(state.error));
        }
        return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ContactCard(
                name: contacts[index].name!,
                onEdit: () {
                  Navigator.of(context)
                      .push(EditContactScreen.route(id: contacts[index].id!))
                      .then((_) => contactListBloc.getList());
                },
                onDelete: () {
                  contactListBloc.remove(contacts[index].id!);
                  contactListBloc.getList();
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: contacts.length);
      }),
    );
  }
}
