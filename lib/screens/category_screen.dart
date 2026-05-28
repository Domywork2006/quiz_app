import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {

  const CategoryScreen({
    super.key,
    required this.selectCategory,
  });

  final void Function(String category)
      selectCategory;

  Widget buildCategoryButton(
    String title,
    IconData icon,
    Color color,
  ) {

    return Container(

      margin: const EdgeInsets.only(
        bottom: 20,
      ),

      child: ElevatedButton(

        onPressed: () {
          selectCategory(title);
        },

        style: ElevatedButton.styleFrom(

          backgroundColor: color,

          foregroundColor: Colors.white,

          padding:
              const EdgeInsets.symmetric(
            vertical: 20,
          ),

          elevation: 15,

          shadowColor: color,

          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(25),
          ),
        ),

        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [

            Icon(
              icon,
              size: 30,
            ),

            const SizedBox(width: 15),

            Text(
              title,

              style: const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.all(30),

      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        crossAxisAlignment:
            CrossAxisAlignment.stretch,

        children: [

          const Text(
            'Choose Category',

            textAlign: TextAlign.center,

            style: TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 50),

          buildCategoryButton(
            'Programming',
            Icons.code,
            Colors.deepPurple,
          ),

          buildCategoryButton(
            'Science',
            Icons.science,
            Colors.blue,
          ),

          buildCategoryButton(
            'Sports',
            Icons.sports_soccer,
            Colors.green,
          ),

          buildCategoryButton(
            'Flutter',
            Icons.flutter_dash,
            Colors.cyan,
          ),
        ],
      ),
    );
  }
}