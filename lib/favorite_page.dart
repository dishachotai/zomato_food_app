import 'package:flutter/material.dart';
class FavoritePage extends StatelessWidget {
  final List favList;

  const FavoritePage({
    super.key,
    required this.favList,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(

        backgroundColor: Colors.red,

        title: const Text(
          "Favorite Foods",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: favList.isEmpty

          ? const Center(
        child: Text(
          "No Favorite Food ❤️",

          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      )

          : ListView.builder(

        itemCount: favList.length,

        itemBuilder: (context, index) {

          return Container(

            margin: const EdgeInsets.all(12),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius:
              BorderRadius.circular(15),

              boxShadow: [

                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                ),
              ],
            ),

            child: ListTile(

              contentPadding:
              const EdgeInsets.all(10),

              leading: ClipRRect(

                borderRadius:
                BorderRadius.circular(10),

                child: Image.network(
                  favList[index]['image'],

                  width: 70,
                  height: 70,

                  fit: BoxFit.cover,
                ),
              ),

              title: Text(
                favList[index]['name'],

                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              subtitle: Text(
                "₹ ${favList[index]['price']}",
              ),

              trailing: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}