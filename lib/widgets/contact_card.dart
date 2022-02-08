import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  const ContactCard(
      {Key? key,
      required this.name,
      required this.onEdit,
      required this.onDelete})
      : super(key: key);
  final String name;
  final Function onEdit;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(name),
            Row(
              children: <Widget>[
                IconButton(
                    onPressed: () {
                      onEdit();
                    },
                    icon: const Icon(Icons.edit)),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: () {
                      onDelete();
                    },
                    icon: const Icon(Icons.delete)),
              ],
            ),
          ],
        ));
  }
}
