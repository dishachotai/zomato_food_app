import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// Admin order management screen
// Allows the admin to view orders and update their status.

class AdminOrdersPage extends StatelessWidget {
  const AdminOrdersPage({super.key});

// Available order status options
  final List<String> statuses = const [
    "Placed",
    "Preparing",
    "Out for Delivery",
    "Delivered",
  ];

 // Updates the selected order status in Firestore

  Future<void> updateStatus(
    String orderId,
    String newStatus,
  ) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .update({
      "status": newStatus,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Manage Orders",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

 // StreamBuilder listens to Firestore changes in real time

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .orderBy("orderDate", descending: true)
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

 // Displays an error message if Firestore request fails

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
              child: Text(
                "No Orders Found",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          // Stores all fetched order documents
          final orders = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,

            itemBuilder: (context, index) {
              final orderDocument = orders[index];

              final order =
                  orderDocument.data()
                      as Map<String, dynamic>;

              final String orderId =
                  orderDocument.id;

              final String name =
                  order["customerName"] ?? "Customer";

              final String status =
                  order["status"] ?? "Placed";

              final double total =
                  (order["grandTotal"] ?? 0).toDouble();

              final String payment =
                  order["paymentMethod"] ??
                      "Cash on Delivery";

        // Displays all orders in a scrollable list
        
              return Card(
                margin: const EdgeInsets.only(
                  bottom: 15,
                ),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // Displays customer name and current order status
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 19,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                           // Displays the current status as a badge
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: Text(
                              status,
                              style: const TextStyle(
                                color: Colors.red,
                                fontWeight:
                                    FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Payment: $payment",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Total: ₹${total.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Update Order Status",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Dropdown for changing the order status

                      DropdownButtonFormField<String>(
                        initialValue: statuses.contains(status)
                            ? status
                            : "Placed",
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                        ),

                         // Creates dropdown options from the status list

                        items: statuses.map((statusItem) {
                          return DropdownMenuItem<String>(
                            value: statusItem,
                            child: Text(statusItem),
                          );
                        }).toList(),

                         // Called when the admin selects a new status
                        onChanged: (newStatus) async {
                          if (newStatus == null) {
                            return;
                          }
                          try {
                            // Updates the selected status in Firestore
                            await updateStatus(
                              orderId,
                              newStatus,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Status updated to $newStatus",
                                  ),
                                  backgroundColor:
                                      Colors.green,
                                ),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Error: $e",
                                  ),
                                  backgroundColor:
                                      Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
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