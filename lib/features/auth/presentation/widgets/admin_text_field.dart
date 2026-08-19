import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../enums/login_field_type.dart';

class AdminTextField extends StatelessWidget {
  final LoginFieldType type;
  final TextEditingController controller;

  const AdminTextField({
    required this.type,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final labelKey = switch (type) {
      LoginFieldType.email => 'login.email',
      LoginFieldType.password => 'login.password',
    };
    final isPassword = type == LoginFieldType.password;

    return TextField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: isPassword
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      autofillHints: isPassword
          ? const [AutofillHints.password]
          : const [AutofillHints.email],
      decoration: InputDecoration(
        labelText: labelKey.tr(),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
