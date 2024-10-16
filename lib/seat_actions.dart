import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seat_provider.dart';

class SeatActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final seatProvider = Provider.of<SeatProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              seatProvider.confirmSelection('user123'); // Pass the userId dynamically
            },
            child: Text('CONFIRM'),
          ),
          OutlinedButton(
            onPressed: () {
              seatProvider.cancelSelection();
            },
            child: Text('CANCEL'),
          ),
        ],
      ),
    );
  }
}
