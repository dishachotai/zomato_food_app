import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'order_details_page.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: user == null
          ? const Center(
              child: Text(
                "Please login first",
                style: TextStyle(fontSize: 18),
              ),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("orders")
                  .where(
                    "userId",
                    isEqualTo: user.uid,
                  )
                  .snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Error: ${snapshot.error}",
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (!snapshot.hasData ||
                    snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_bag_outlined,
                          size: 80,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 15),
                        Text(
                          "No Orders Yet",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Your orders will appear here.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                final orders = snapshot.data!.docs;

                return ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: orders.length,

                  itemBuilder: (context, index) {
                    final orderDocument = orders[index];

                    final order =
                        orderDocument.data()
                            as Map<String, dynamic>;

                    final List items =
                        order["items"] ?? [];

                    final String status =
                        order["status"] ?? "Placed";

                    final String paymentMethod =
                        order["paymentMethod"] ??
                            "Cash on Delivery";

                    final double grandTotal =
                        (order["grandTotal"] ?? 0)
                            .toDouble();

                    return Card(
                      margin:
                          const EdgeInsets.only(bottom: 15),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15),
                      ),

                      child: InkWell(
                        borderRadius:
                            BorderRadius.circular(15),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OrderDetailsPage(
                                order: order,
                              ),
                            ),
                          );
                        },

                        child: Padding(
                          padding:
                              const EdgeInsets.all(16),

                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                                 Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                children: [
                                  const Text(
                                    "Order",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets
                                            .symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration:
                                        BoxDecoration(
                                      color: Colors.green
                                          .withOpacity(0.1),
                                      borderRadius:
                                          BorderRadius
                                              .circular(20),
                                    ),
                                    child: Text(
                                      status,
                                      style:
                                          const TextStyle(
                                        color:
                                            Colors.green,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(height: 25),
                              const Text(
                                "Items",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...items.map(
                                (item) {
                                  final String name =
                                      item["name"] ??
                                          "Food Item";

                                  final int quantity =
                                      item["qty"] ?? 1;

                                  final double price =
                                      (item["price"] ?? 0)
                                          .toDouble();

                                  return Padding(
                                    padding:
                                        const EdgeInsets
                                            .only(
                                      bottom: 6,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "$name × $quantity",
                                            style:
                                                const TextStyle(
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),

                                        Text(
                                          "₹${(price * quantity).toStringAsFixed(0)}",
                                          style:
                                              const TextStyle(
                                            fontWeight:
                                                FontWeight
                                                    .w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

                              const Divider(height: 25),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                children: [
                                  const Text(
                                    "Payment",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(paymentMethod),
                                ],
                              ),

                              const SizedBox(height: 10),
                               Row(
                                mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,
                                children: [
                                  const Text(
                                    "Total",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    "₹${grandTotal.toStringAsFixed(0)}",
                                    style:
                                        const TextStyle(
                                      fontSize: 20,
                                      fontWeight:
                                          FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 15),
                              Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    color: Colors.red,
                                    size: 20,
                                  ),

                                  const SizedBox(width: 8),

                                  Expanded(
                                    child: Text(
                                      "${order["address"] ?? ""}, "
                                      "${order["city"] ?? ""} - "
                                      "${order["pincode"] ?? ""}",
                                      style:
                                          const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "View Details",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight:
                                          FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}