import 'package:flutter/material.dart';

class TopHeading extends StatelessWidget {
  final String title;
  final dynamic colour;
  const TopHeading({super.key, required this.title, this.colour});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}
