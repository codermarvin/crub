import 'package:crud/feature/contacts/models/contact.dto.dart';
import 'package:crud/feature/contacts/presentation/bloc/contact_list_bloc.dart';
import 'package:crud/feature/contacts/presentation/bloc/contact_list_state.dart';
import 'package:crud/widgets/app_text_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditContactScreen extends StatefulWidget {
  const EditContactScreen({Key? key, required this.id}) : super(key: key);
  final int id;

  static const String routeName = '/editContact';
  static const String screenName = 'EditContactScreen';
  static ModalRoute<void> route({required int id}) => MaterialPageRoute<void>(
      builder: (_) => EditContactScreen(id: id),
      settings: const RouteSettings(name: routeName));

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  late ContactListBloc contactListBloc;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    contactListBloc = BlocProvider.of<ContactListBloc>(context);
    contactListBloc.getById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
        actions: <Widget>[
          BlocListener<ContactListBloc, ContactListState>(
              listener: (BuildContext context, ContactListState state) {
            if (state is UpdateContactSuccessState) {
              Navigator.of(context).pop();
            } else if (state is UpdateContactFailedState) {
              if (kDebugMode) {
                print(state.error);
              }
            }
          }, child: BlocBuilder<ContactListBloc, ContactListState>(
                  builder: (BuildContext context, ContactListState state) {
            if (state is UpdateContactLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return IconButton(
                onPressed: () {
                  contactListBloc.update(widget.id,
                      Contact(id: widget.id, name: nameController.text));
                },
                icon: const Icon(Icons.check));
          })),
        ],
      ),
      body: BlocBuilder<ContactListBloc, ContactListState>(
          builder: (BuildContext context, ContactListState state) {
        if (state is GetContactLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetContactSuccessState) {
          nameController.text = state.contact.name!;
        }
        if (state is GetContactFailedState) {
          return Center(child: Text(state.error));
        }
        return ListView(
          children: <Widget>[
            AppTextFormField(label: 'Name', controller: nameController),
          ],
        );
      }),
    );
  }
}
