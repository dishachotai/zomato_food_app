import 'package:flutter/material.dart';
import 'favorite_page.dart';
import 'profile_page.dart';
import 'cart_page.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({super.key});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  final TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;

  List<Map<String, dynamic>> foodList = [
    {
      "name": "Classic Burger",
      "price": 120,
      "qty": null,
      "type": "Veg",
      "category": "Burger",
      "fav": false,
      "description": "Classic veg burger with fresh vegetables",
      "image":
          "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Cheese Burger",
      "price": 160,
      "qty": null,
      "type": "Veg",
      "category": "Burger",
      "fav": false,
      "description": "Delicious burger loaded with cheese",
      "image":
          "https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Veggie Burger",
      "price": 140,
      "qty": null,
      "type": "Veg",
      "category": "Burger",
      "fav": false,
      "description": "Healthy burger with fresh vegetables",
      "image":
          "https://images.unsplash.com/photo-1520072959219-c595dc870360?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Spicy Burger",
      "price": 150,
      "qty": null,
      "type": "Veg",
      "category": "Burger",
      "fav": false,
      "description": "Spicy burger with special sauce",
      "image":
          "https://images.unsplash.com/photo-1572802419224-296b0aeee0d9?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Margherita Pizza",
      "price": 220,
      "qty": null,
      "type": "Veg",
      "category": "Pizza",
      "fav": false,
      "description": "Classic pizza with cheese and tomato",
      "image":
          "https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Cheese Pizza",
      "price": 250,
      "qty": null,
      "type": "Veg",
      "category": "Pizza",
      "fav": false,
      "description": "Extra cheesy pizza",
      "image":
          "https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Veggie Pizza",
      "price": 280,
      "qty": null,
      "type": "Veg",
      "category": "Pizza",
      "fav": false,
      "description": "Pizza loaded with fresh vegetables",
      "image":
          "https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Paneer Pizza",
      "price": 300,
      "qty": null,
      "type": "Veg",
      "category": "Pizza",
      "fav": false,
      "description": "Delicious paneer pizza with cheese",
      "image":
          "https://images.unsplash.com/photo-1579751626657-72bc17010498?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "White Sauce Pasta",
      "price": 180,
      "qty": null,
      "type": "Veg",
      "category": "Pasta",
      "fav": false,
      "description": "Creamy white sauce pasta",
      "image":
          "https://images.unsplash.com/photo-1645112411341-6c4fd023714a?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Red Sauce Pasta",
      "price": 170,
      "qty": null,
      "type": "Veg",
      "category": "Pasta",
      "fav": false,
      "description": "Pasta with rich tomato sauce",
      "image":
          "https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Alfredo Pasta",
      "price": 220,
      "qty": null,
      "type": "Veg",
      "category": "Pasta",
      "fav": false,
      "description": "Creamy Alfredo pasta with cheese",
      "image":
          "https://images.unsplash.com/photo-1473093295043-cdd812d0e601?auto=format&fit=crop&w=800&q=60",
    },
  
   {
      "name": "Veg Sandwich",
      "price": 90,
      "qty": null,
      "type": "Veg",
      "category": "Sandwich",
      "fav": false,
      "description": "Fresh vegetable sandwich",
      "image":
          "https://images.unsplash.com/photo-1528735602780-2552fd46c7af?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Cheese Sandwich",
      "price": 120,
      "qty": null,
      "type": "Veg",
      "category": "Sandwich",
      "fav": false,
      "description": "Grilled cheese sandwich",
      "image":
          "https://images.unsplash.com/photo-148 sandwich?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Grilled Sandwich",
      "price": 140,
      "qty": null,
      "type": "Veg",
      "category": "Sandwich",
      "fav": false,
      "description": "Crispy grilled sandwich with vegetables",
      "image":
          "https://images.unsplash.com/photo-1553909489-cd47e0907980?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Club Sandwich",
      "price": 160,
      "qty": null,
      "type": "Veg",
      "category": "Sandwich",
      "fav": false,
      "description": "Delicious layered vegetable sandwich",
      "image":
          "https://images.unsplash.com/photo-1567234669003-dce7a7a8889c?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Chocolate Cake",
      "price": 150,
      "qty": null,
      "type": "Veg",
      "category": "Cake",
      "fav": false,
      "description": "Rich chocolate cake",
      "image":
          "https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Red Velvet Cake",
      "price": 180,
      "qty": null,
      "type": "Veg",
      "category": "Cake",
      "fav": false,
      "description": "Soft red velvet cake",
      "image":
          "https://images.unsplash.com/photo-1586788680434-30d324b2d46f?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Vanilla Cake",
      "price": 140,
      "qty": null,
      "type": "Veg",
      "category": "Cake",
      "fav": false,
      "description": "Soft vanilla cream cake",
      "image":
          "https://images.unsplash.com/photo-1571115177098-24ec42ed204d?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Classic Cold Coffee",
      "price": 110,
      "qty": null,
      "type": "Veg",
      "category": "Cold Coffee",
      "fav": false,
      "description": "Refreshing classic cold coffee",
      "image":
          "https://images.unsplash.com/photo-1517701604599-bb29b565090c?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Chocolate Cold Coffee",
      "price": 140,
      "qty": null,
      "type": "Veg",
      "category": "Cold Coffee",
      "fav": false,
      "description": "Cold coffee with chocolate",
      "image":
          "https://images.unsplash.com/photo-1461023058943-07fcbe16d735?auto=format&fit=crop&w=800&q=60",
    },

    {
      "name": "Mocha Coffee",
      "price": 160,
      "qty": null,
      "type": "Veg",
      "category": "Cold Coffee",
      "fav": false,
      "description": "Creamy mocha cold coffee",
      "image":
          "https://images.unsplash.com/photo-1512568400610-62da28bc8a13?auto=format&fit=crop&w=800&q=60",
    },
  ];

  List<Map<String, dynamic>> searchList = [];
  List<Map<String, dynamic>> favList = [];
  List<Map<String, dynamic>> cartList = [];

  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    searchList = List.from(foodList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,

      appBar: AppBar(
        backgroundColor: Colors.red,

        title: const Text(
          "Zomato",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Card_Page(
                      cartList: cartList,
                      totalPrice: totalPrice,
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 32,
                  ),
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 9,
                      backgroundColor: Colors.white,
                      child: Text(
                        cartList.length.toString(),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchList = foodList.where((food) {
                    return food["name"]
                        .toString()
                        .toLowerCase()
                        .contains(value.toLowerCase());
                  }).toList();
                });
              },
              decoration: InputDecoration(
                hintText: "Search food...",
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchList = List.from(foodList);
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 95,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                categoryBox("🍕", "Pizza"),
                categoryBox("🍔", "Burger"),
                categoryBox("🍝", "Pasta"),
                categoryBox("🥪", "Sandwich"),
                categoryBox("🍰", "Cake"),
                categoryBox("☕", "Cold Coffee"),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      searchList = List.from(foodList);
                    });
                  },
                  child: Container(
                    width: 90,
                    margin: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Center(
                      child: Text(
                        "All",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              children: [
                const Text(
                  "Popular Foods",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      searchList = List.from(foodList);
                    });
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: searchList.isEmpty
                ? const Center(
                    child: Text(
                      "No food found",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: searchList.length,
                    itemBuilder: (context, index) {
                      final food = searchList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 7,
                        ),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(12),
                                    child: Image.network(
                                      food["image"],
                                      height: 110,
                                      width: 110,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          height: 110,
                                          width: 110,
                                          color: Colors.grey.shade300,
                                          child: const Icon(
                                            Icons.fastfood,
                                            size: 40,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                              Positioned(
                                    top: 5,
                                    right: 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          food["fav"] =
                                              !food["fav"];
                                          if (food["fav"]) {
                                            if (!favList.contains(food)) {
                                              favList.add(food);
                                            }
                                          } else {
                                            favList.remove(food);
                                          }
                                        });
                                      },
                                      child: CircleAvatar(
                                        radius: 16,
                                        backgroundColor:
                                            Colors.white,
                                        child: Icon(
                                          food["fav"]
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      food["name"],
                                      style:const TextStyle(
                                        fontSize: 20,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      food["description"],
                                      maxLines: 2,
                                      overflow:
                                          TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Text(
                                          "₹ ${food["price"]}",
                                          style:
                                              const TextStyle(
                                            fontSize: 18,
                                            fontWeight:
                                                FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        food["qty"] == null
                                            ? ElevatedButton(
                                                style:
                                                    ElevatedButton
                                                        .styleFrom(
                                                  backgroundColor:
                                                      Colors.red,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    food["qty"] = 1;
                                                    if (!cartList
                                                        .contains(
                                                            food)) {
                                                      cartList
                                                          .add(food);
                                                    }
                                                    totalPrice +=
                                                        food["price"]
                                                            as int;
                                                  });
                                                },
                                                child:
                                                    const Text(
                                                  "ADD",
                                                  style: TextStyle(
                                                    color:
                                                        Colors.white,
                                                  ),
                                                ),
                                              )
                                        : Container(
                                                height: 38,
                                                width: 110,
                                                decoration:
                                                    BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius
                                                          .circular(8),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (food["qty"] >
                                                              1) {
                                                            food["qty"]--;

                                                            totalPrice -=
                                                                food["price"]
                                                                    as int;
                                                          } else {
                                                            totalPrice -=
                                                                food["price"]
                                                                    as int;
                                                            food["qty"] =
                                                                null;
                                                            cartList
                                                                .remove(
                                                                    food);
                                                          }
                                                        });
                                                      },
                                                      child:
                                                          const Icon(
                                                        Icons.remove,
                                                        color: Colors
                                                            .white,
                                                        size: 20,
                                                      ),
                                                    ),
                                                    Text(
                                                      "${food["qty"]}",
                                                      style:
                                                          const TextStyle(
                                                        color: Colors
                                                            .white,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          food["qty"]++;
                                                          totalPrice +=
                                                              food["price"]
                                                                  as int;
                                                        });
                                                      },
                                                      child:
                                                          const Icon(
                                                        Icons.add,
                                                        color: Colors
                                                            .white,
                                                        size: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (cartList.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              color: Colors.white,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Total Price",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "₹ $totalPrice",
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Card_Page(
                            cartList: cartList,
                            totalPrice: totalPrice,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Checkout",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: Colors.red,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FavoritePage(
                  favList: favList,
                ),
              ),
            );
          }
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(
              favList: favList,
                ),
              ),  
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
  Widget categoryBox(
    String emoji,
    String name,
  ) {
    return GestureDetector(
      onTap: () {
        setState(() {
          searchList = foodList
              .where(
                (food) => food["category"] == name,
              )
              .toList();
        });
      },
      child: Container(
        width: 90,
        margin: const EdgeInsets.only(
          left: 12,
        ),
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
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
} 