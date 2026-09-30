import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailsPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final List items = order["items"] ?? [];

    final double total =
        (order["grandTotal"] ?? 0).toDouble();

    final String status =
        order["status"] ?? "Placed";

    final String payment =
        order["paymentMethod"] ?? "Cash on Delivery";

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Order Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "Order Status",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(15),
              ),
              child: Column(
                children: [

                  _statusItem(
                    icon: Icons.check_circle,
                    title: "Order Placed",
                    active: true,
                  ),

                  _statusLine(),

                  _statusItem(
                    icon: Icons.restaurant,
                    title: "Preparing",
                    active: status == "Preparing" ||
                        status == "Out for Delivery" ||
                        status == "Delivered",
                  ),

                  _statusLine(),

                  _statusItem(
                    icon: Icons.delivery_dining,
                    title: "Out for Delivery",
                    active: status == "Out for Delivery" ||
                        status == "Delivered",
                  ),

                  _statusLine(),

                  _statusItem(
                    icon: Icons.home,
                    title: "Delivered",
                    active: status == "Delivered",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Ordered Items",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  ...items.map((item) {
                    final String name =
                        item["name"] ?? "Food Item";

                    final int qty =
                        item["qty"] ?? 1;

                    final double price =
                        (item["price"] ?? 0).toDouble();

                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 12,
                      ),
                      child: Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "$name × $qty",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            "₹${(price * qty).toStringAsFixed(0)}",
                            style: const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Payment & Total",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(15),
              ),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Payment"),
                      Text(payment),
                    ],
                  ),

                  const Divider(height: 25),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Grand Total",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                      Text(
                        "₹${total.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              "Delivery Address",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "${order["customerName"] ?? ""}\n"
                      "${order["phone"] ?? ""}\n"
                      "${order["address"] ?? ""}, "
                      "${order["city"] ?? ""} - "
                      "${order["pincode"] ?? ""}",
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _statusItem({
    required IconData icon,
    required String title,
    required bool active,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: active ? Colors.green : Colors.grey,
          size: 28,
        ),
        const SizedBox(width: 15),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: active
                ? Colors.green
                : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _statusLine() {
    return Container(
      margin: const EdgeInsets.only(
        left: 13,
      ),
      height: 25,
      width: 2,
      color: Colors.grey.shade300,
    );
  }
}