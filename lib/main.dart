import 'package:crud/app/app.dart';
import 'package:crud/feature/contacts/presentation/bloc/contact_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: <BlocProvider<dynamic>>[
    BlocProvider<ContactListBloc>(
        create: (BuildContext context) => ContactListBloc()),
  ], child: const App()));
}
