import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController textController;
  final bool isEnable;
  final String title;

  const CustomTextField({
    super.key,
    required this.textController,
    required this.isEnable,
    required this.title,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: widget.textController,
          enabled: widget.isEnable,
          style: const TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
