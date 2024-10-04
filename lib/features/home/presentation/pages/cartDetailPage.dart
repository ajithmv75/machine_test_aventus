import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:machine_test/core/utils/app_snackbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class ProductDetailPage extends StatefulWidget {
  final String productId;

  const ProductDetailPage({Key? key, required this.productId}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    final orderId = response.paymentId;

    try {
      final product = await FirebaseFirestore.instance.collection('product').doc(widget.productId).get();
      final productName = product['name'];
      final productPrice = (product['price'] is int)
          ? (product['price'] as int).toDouble()
          : product['price'];

      await FirebaseFirestore.instance.collection('orders').add({
        'orderId': orderId,
        'productId': widget.productId,
        'productName': productName,
        'price': productPrice,
        'timestamp': FieldValue.serverTimestamp(),
      });


      appSncakBar(context: context,message: "Payment Successful: $orderId");

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving order: ${e.toString()}")),
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Payment Failed: ${response.message}")),
    );
  }

  void _openCheckout(String productName, double price) {
    var options = {
      'key': 'rzp_test_tOuoihHsvURpVn',
      'amount': (price * 100).toString(),
      'name': productName,
      'description': 'Product Purchase',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '9567815174', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('product').doc(widget.productId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text("Product not found."));
          }

          final product = snapshot.data!;
          final productName = product['name'];
          final productPrice = (product['price'] is int)
              ? (product['price'] as int).toDouble()
              : product['price'];
          final productImage = product['image'];

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(title: Text(productName)),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    Image.network(productImage),
                    SizedBox(height: 16),
                    Text(productName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('\$${productPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _openCheckout(productName, productPrice),
                      child: Text("Buy"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
