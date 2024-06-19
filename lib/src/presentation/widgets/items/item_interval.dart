import 'package:flutter/material.dart';

class ItemInterval extends StatelessWidget {
  final bool isActive;
  final String label;
  final VoidCallback onPressed;
  
  const ItemInterval({
    super.key,
    required this.isActive,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(8),
          color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
        ),
        child: Center(
          child: Text(label, style: TextStyle(color: isActive ? Colors.white : Colors.black),),
        ),
      ),
    );
  }
}
