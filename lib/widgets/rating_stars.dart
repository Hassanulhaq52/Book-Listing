import 'package:book_listing_app/widgets/star_icon.dart';
import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const StarIcon(),
        const StarIcon(),
        const StarIcon(),
        const StarIcon(),
        Icon(Icons.star, color: Colors.grey.shade400, size: 18),
      ],
    );
  }
}
