import 'package:flutter/material.dart';
import 'food_list.dart';

class FoodDetailPage extends StatefulWidget {
  final Food food;
  final String username;

  const FoodDetailPage({super.key, required this.food, required this.username});

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  final TextEditingController _quantityController = TextEditingController(text: '1');
  int _quantity = 1;
  int _totalPrice = 0;

  @override
  void initState() {
    super.initState();
    _totalPrice = widget.food.price * _quantity;
  }

  void _checkout() {
    int? qty = int.tryParse(_quantityController.text);
    if (qty == null || qty <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Masukkan jumlah yang valid')),
      );
      return;
    }
    setState(() {
      _quantity = qty;
      _totalPrice = widget.food.price * _quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              width: double.infinity,
              height: 200,
              child: Image.network(
                widget.food.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.food.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        widget.food.category,
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Harga: Rp ${widget.food.price}'),
                      Text('${widget.food.calories} cal'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Deskripsi: ${widget.food.description}'),
                  const SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14),
                      children: [
                        const TextSpan(
                            text: 'Komposisi: ',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: widget.food.ingredients.join(', ')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _quantityController,
                          decoration: const InputDecoration(
                            labelText: 'jumlah pesan',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            int? qty = int.tryParse(value);
                            if (qty != null && qty > 0) {
                              setState(() {
                                _quantity = qty;
                                _totalPrice = widget.food.price * _quantity;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Harga Total'),
                          Text('Rp $_totalPrice',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _checkout,
                      child: const Text('Checkout'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}