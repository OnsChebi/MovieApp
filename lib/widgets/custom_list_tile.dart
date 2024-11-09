import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final VoidCallback? onTap;
  final double? height;

  const CustomListTile({
    Key? key,
    this.leading,
    this.title,
    this.onTap,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: height,
          child: Row(
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: leading,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (title != null) title!,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
