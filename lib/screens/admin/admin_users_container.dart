import 'package:doacao_leite/screens/admin/admin_users_detail_screen.dart';
import 'package:doacao_leite/utils/routers.dart';
import 'package:flutter/material.dart';

class AdminUsersField extends StatefulWidget {
  AdminUsersField({
    Key? key,
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.address,
    this.active,
    this.role,
    this.createdAt,
    this.updatedAt,
  }) : super(key: key);

  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? phone;
  final String? address;
  final bool? active;
  final String? role;
  final String? createdAt;
  final String? updatedAt;

  @override
  _AdminUsersFieldState createState() => _AdminUsersFieldState();
}

class _AdminUsersFieldState extends State<AdminUsersField> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        PageNavigator(ctx: context).nextPage(
          page: AdminUsersDetailScreen(
            id: widget.id,
            name: widget.name,
            email: widget.email,
            phone: widget.phone,
            address: widget.address,
            active: widget.active,
            role: widget.role,
            createdAt: widget.createdAt,
            updatedAt: widget.updatedAt ?? '0000-01-01T03:00:00.000000Z',
          ),
        );
      },
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        widget.name!,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Row(
        children: [
          const Text(
            'Role: ',
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.role!,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          const Text(
            ' -- Ativo: ',
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            widget.active!.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      minLeadingWidth: 28,
      leading: Text(
        widget.id!,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      //trailing:
    );
  }
}
