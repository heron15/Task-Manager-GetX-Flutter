import 'package:flutter/material.dart';

class TopHeaderText extends StatelessWidget {
  const TopHeaderText({
    super.key,
    required this.header,
    required this.subHeader,
  });

  final String header;
  final String subHeader;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50, bottom: 30),
      child: Column(
        children: [
          Text(
            header,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              subHeader,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}
