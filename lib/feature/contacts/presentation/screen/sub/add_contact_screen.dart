import 'package:crud/feature/contacts/models/contact.dto.dart';
import 'package:crud/feature/contacts/presentation/bloc/contact_list_bloc.dart';
import 'package:crud/feature/contacts/presentation/bloc/contact_list_state.dart';
import 'package:crud/widgets/app_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({Key? key}) : super(key: key);

  static const String routeName = '/addContact';
  static const String screenName = 'AddContactScreen';
  static ModalRoute<void> route() => MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => const AddContactScreen(),
      settings: const RouteSettings(name: routeName));

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  late ContactListBloc contactListBloc;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    contactListBloc = BlocProvider.of<ContactListBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Contact'),
        actions: <Widget>[
          BlocListener<ContactListBloc, ContactListState>(
              listener: (BuildContext context, ContactListState state) {
            if (state is AddContactSuccessState) {
              Navigator.of(context).pop();
            } else if (state is AddContactFailedState) {
              if (kDebugMode) {
                print(state.error);
              }
            }
          }, child: BlocBuilder<ContactListBloc, ContactListState>(
                  builder: (BuildContext context, ContactListState state) {
            if (state is AddContactLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return IconButton(
                onPressed: () {
                  contactListBloc.add(Contact(name: nameController.text));
                },
                icon: const Icon(Icons.check));
          })),
        ],
      ),
      body: ListView(
        children: <Widget>[
          AppTextFormField(label: 'Name', controller: nameController),
        ],
      ),
    );
  }
}
