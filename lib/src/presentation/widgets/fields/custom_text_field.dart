import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFieldBase extends StatelessWidget {
  final Widget child;

  const CustomFieldBase({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 4.0,
        bottom: 4.0,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        color: Colors.white,
      ),
      child: child,
    );
  }
}

class CustomField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final String? errorMessage;

  const CustomField({
    super.key,
    required this.labelText,
    required this.controller,
    this.onChanged,
    this.keyboardType,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return CustomFieldBase(
      child: TextField(
        obscureText: keyboardType == TextInputType.visiblePassword,
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          errorText: errorMessage,
          label: Text(labelText),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
