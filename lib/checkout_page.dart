import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'food_page.dart';

// Checkout screen used to collect delivery details,
// select payment method, calculate total amount,
// and place the order in Firestore.
class CheckoutPage extends StatefulWidget {
  final List cartList;

  const CheckoutPage({
    super.key,
    required this.cartList,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Form key used for validating all input fields
  final _formKey = GlobalKey<FormState>();

  // Controllers for delivery information
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController phoneController =
      TextEditingController();

  final TextEditingController addressController =
      TextEditingController();

  final TextEditingController cityController =
      TextEditingController();

  final TextEditingController pincodeController =
      TextEditingController();

  // Default payment method
  String paymentMethod = "Cash on Delivery";

  // Controls the loading state of the Place Order button
  bool isLoading = false;

  // Calculates the subtotal from all cart items
  double get subtotal {
    double total = 0;

    for (var item in widget.cartList) {
      double price = (item["price"] ?? 0).toDouble();
      int quantity = item["qty"] ?? 1;
      total += price * quantity;
    }
    return total;
  }
  // Provides free delivery for orders of ₹500 or more
  double get deliveryCharge {
    return subtotal >= 500 ? 0 : 40;
  }

  // Calculates the final payable amount
  double get grandTotal {
    return subtotal + deliveryCharge;
  }

  @override
  void dispose() {
    // Dispose controllers when the screen is removed
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    pincodeController.dispose();

    super.dispose();
  }

  // Validates the form and saves the order to Firestore
  Future<void> placeOrder() async {
    // Stop if any required field is invalid
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Prevent placing an order with an empty cart
    if (widget.cartList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Your cart is empty"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // Shows loading state while placing the order
    setState(() {
      isLoading = true;
    });

    try {
      // Gets the currently logged-in Firebase user
      final user = FirebaseAuth.instance.currentUser;

      // User must be logged in before placing an order
      if (user == null) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please login first"),
            backgroundColor: Colors.red,
          ),
        );

        setState(() {
          isLoading = false;
        });

        return;
      }

      // Saves the order details to Firestore
      await FirebaseFirestore.instance
          .collection("orders")
          .add({
        "userId": user.uid,
        "email": user.email ?? "",
        "customerName": nameController.text.trim(),
        "phone": phoneController.text.trim(),
        "address": addressController.text.trim(),
        "city": cityController.text.trim(),
        "pincode": pincodeController.text.trim(),
        "paymentMethod": paymentMethod,
        "items": List.from(widget.cartList),
        "subtotal": subtotal,
        "deliveryCharge": deliveryCharge,
        "grandTotal": grandTotal,

        // Initial order status
        "status": "Placed",

        // Stores the server timestamp when the order is created
        "orderDate": FieldValue.serverTimestamp(),
      });
      if (!mounted) return;
      // Stops the loading indicator
      setState(() {
        isLoading = false;
      });
      // Navigates to the order success screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSuccessPage(
            totalAmount: grandTotal,
            paymentMethod: paymentMethod,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      // Stops the loading indicator if an error occurs
      setState(() {
        isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Order failed: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  // Reusable input field with validation
  Widget inputField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Delivery Address",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              inputField(
                label: "Full Name",
                icon: Icons.person,
                controller: nameController,
              ),
              inputField(
                label: "Mobile Number",
                icon: Icons.phone,
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
                inputField(
                label: "Address",
                icon: Icons.home,
                controller: addressController,
              ),
              inputField(
                label: "City",
                icon: Icons.location_city,
                controller: cityController,
              ),
              inputField(
                label: "Pincode",
                icon: Icons.pin_drop,
                controller: pincodeController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              const Text(
                "Payment Method",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              RadioListTile<String>(
                value: "Cash on Delivery",
                groupValue: paymentMethod,
                title: const Text("Cash on Delivery"),
                secondary: const Icon(Icons.money),

                onChanged: (value) {
                  setState(() {
                    paymentMethod = value!;
                  });
                },
              ),

              RadioListTile<String>(
                value: "UPI",
                groupValue: paymentMethod,
                title: const Text("UPI"),
                secondary: const Icon(
                  Icons.account_balance_wallet,
                ),

                onChanged: (value) {
                  setState(() {
                    paymentMethod = value!;
                  });
                },
              ),
              RadioListTile<String>(
                value: "Card",
                groupValue: paymentMethod,
                title: const Text("Credit / Debit Card"),
                secondary: const Icon(Icons.credit_card),

                onChanged: (value) {
                  setState(() {
                    paymentMethod = value!;
                  });
                },
              ),
              const SizedBox(height: 15),              
              const Text(
                "Order Summary",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              // Displays subtotal delivery charge and grand total
              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Subtotal"),
                        Text(
                          "₹${subtotal.toStringAsFixed(0)}",
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Delivery"),
                        Text(
                          deliveryCharge == 0
                              ? "FREE"
                              : "₹${deliveryCharge.toStringAsFixed(0)}",
                        ),
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
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "₹${grandTotal.toStringAsFixed(0)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  // Disables the button while the order is being placed
                  onPressed: isLoading ? null : placeOrder,
                  // Shows a loading indicator while saving the order
                  child: isLoading
                      ? const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : const Text(
                          "Place Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
// Displays confirmation after successfully placing an order
class OrderSuccessPage extends StatelessWidget {
  final double totalAmount;
  final String paymentMethod;

  const OrderSuccessPage({
    super.key,
    required this.totalAmount,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 110,
              ),
              const SizedBox(height: 20),
              const Text(
                "Order Placed Successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Your order of ₹${totalAmount.toStringAsFixed(0)} has been placed.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Payment: $paymentMethod",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Estimated delivery: 30–45 minutes",
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  // Removes previous screens and returns to home
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FoodPage(),
                      ),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}