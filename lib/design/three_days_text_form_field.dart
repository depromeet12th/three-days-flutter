import 'package:flutter/material.dart';

/// 제목, 노티 내용 등의 텍스트 입력하는 위젯
class ThreeDaysTextFormField extends StatelessWidget {
  const ThreeDaysTextFormField({
    super.key,
    required this.hintText,
    required this.maxLength,
    this.controller,
    this.onChanged,
  });

  final String hintText;
  final int maxLength;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0x00c5c5c5),
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      maxLength: maxLength,
      onChanged: onChanged,
    );
  }
}
