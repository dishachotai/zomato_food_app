import 'package:add_to_card/admin_orders_page.dart';
import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'my_orders_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  final List favList;

  const ProfilePage({
    super.key,
    required this.favList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),

            const CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
              ),
            ),

            const SizedBox(height: 15),

            const Text(
              "Disha Chotai",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              "disha@gmail.com",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),
          profileTile(
            context,
            Icons.shopping_bag,
            "My Orders",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyOrdersPage(),
                ),
              );
            },
          ),
            profileTile(
              context,
              Icons.favorite,
              "Favorite Foods",
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritePage(
                      favList: favList,
                    ),
                  ),
                );
              },
            ),
          profileTile(
            context,
            Icons.receipt_long,
            "Manage Orders",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminOrdersPage(),
                ),
              );
            },
          ),
            // LOGOUT
            profileTile(
              context,
              Icons.logout,
              "Logout",
              () {
                _showLogoutDialog(context);
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget profileTile(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.red.shade50,
                child: Icon(
                  icon,
                  color: Colors.red,
                ),
              ),

              const SizedBox(width: 15),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const Spacer(),

              const Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text(
            "Are you sure you want to logout?",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
         onPressed: () async {
        Navigator.pop(context);

        await FirebaseAuth.instance.signOut();
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}