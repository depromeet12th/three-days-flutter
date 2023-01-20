import 'package:flutter/material.dart';

/// 짝심목표 만들기, 짝심목표 수정하기에서 쓰는 작은 제목들
class ThreeDaysSubTitleText extends StatelessWidget {
  const ThreeDaysSubTitleText({
    super.key,
    required this.data,
  });

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
