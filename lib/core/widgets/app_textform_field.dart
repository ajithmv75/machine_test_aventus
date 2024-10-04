import 'package:flutter/material.dart';

class AppTextFormFieldWidget extends StatelessWidget {
  final String text;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  const AppTextFormFieldWidget({
    super.key,
    required this.text,
    this.validator,
    this.autovalidateMode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            TextFormField(
              style: const TextStyle(color: Colors.grey, fontSize: 12),
              cursorColor: Colors.black,
              validator: validator,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                hintText: text,
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: onChanged,
              autovalidateMode: autovalidateMode,
            ),
          ],
        ),
      ),
    );
  }
}
