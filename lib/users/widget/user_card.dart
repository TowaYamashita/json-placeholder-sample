import 'package:flutter/material.dart';
import 'package:json_placeholder_sample/users/model/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.data});

  final User data;

  @override
  Widget build(BuildContext context) {
    showDetail() {
      showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(data.toString()),
            ),
          );
        },
      );
    }

    return Card(
      child: ListTile(
        title: Text(data.name),
        subtitle: Text(data.website),
        onTap: showDetail,
      ),
    );
  }
}
