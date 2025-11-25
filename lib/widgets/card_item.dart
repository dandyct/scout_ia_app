import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final String? semanticLabel;

  const CardItem({
    super.key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    final defaultLeading = CircleAvatar(
      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.12),
      child: Text(
        title.isNotEmpty ? title.substring(0, 1).toUpperCase() : '?',
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );

    return Semantics(
      label: semanticLabel ?? 'Card de $title',
      button: true,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // leading with optional Hero
                if (leading != null)
                  Padding(padding: const EdgeInsets.only(right: 12.0), child: leading!)
                else
                  Padding(padding: const EdgeInsets.only(right: 12.0), child: defaultLeading),
                // content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleMedium),
                      if (subtitle != null) ...[
                        const SizedBox(height: 6),
                        Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ],
                  ),
                ),
                // trailing
                if (trailing != null)
                  trailing!
                else
                  Icon(Icons.chevron_right, color: Theme.of(context).iconTheme.color),
              ],
            ),
          ),
        ),
      ),
    );
  }
}