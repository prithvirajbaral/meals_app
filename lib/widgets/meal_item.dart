import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

// This is a StatelessWidget that represents a single meal item.
class MealItem extends StatelessWidget {
  // Constructor to accept a meal object
  const MealItem({super.key, required this.meal});

  // The meal object passed into this widget
  final Meal meal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      // Margin around the card
      margin: const EdgeInsets.all(8),
      // Shape of the card (rounded corners)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      // Clip behavior determines how child widgets are clipped within the card
      clipBehavior: Clip.hardEdge,
      // Elevation for a shadow effect behind the card
      elevation: 2,
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            // This is an image with a fade-in effect
            FadeInImage(
              // Placeholder while the image is loading
              placeholder: MemoryImage(kTransparentImage),
              // The actual image to display (meal image from URL)
              image: NetworkImage(meal.imageUrl),
              // BoxFit defines how the image should be fit within its container
              fit: BoxFit.cover,
              // Height of the image (200 pixels)
              height: 200,
              // The image takes up the full width of the card
              width: double.infinity,
            ),
            // Positioned widget is used to overlay content over the image
            Positioned(
              // Positioning at the bottom of the stack
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // A semi-transparent black background for the overlay
                color: Colors.black54,
                // Padding around the content inside the container
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [
                    // Text widget to display the meal title
                    Text(
                      meal.title,
                      // Allow only up to 2 lines for the title
                      maxLines: 2,
                      // Center-align the text
                      textAlign: TextAlign.center,
                      // Allow soft wrapping of text (breaking at word boundaries)
                      softWrap: true,
                      // In case the title overflows, ellipsis will be shown
                      overflow: TextOverflow.ellipsis,
                      // Style of the text (bold white text)
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // Spacing between the title and other content (currently an empty row)
                    const SizedBox(
                      height: 12,
                    ),
                    // Empty row for potential content (e.g., ratings, tags)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(
                          icon: Icons.schedule,
                          label: '${meal.duration} min',
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.work,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealItemTrait(
                          icon: Icons.attach_money,
                          label: affordabilityText,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
