import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'seat_actions.dart';
import 'seat_grid.dart';
import 'seat_legend.dart';
import 'seat_provider.dart'; // Make sure you import the SeatProvider

class SeatSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SeatProvider>(
      create: (_) => SeatProvider()..fetchSeats(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Select Seat'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SeatLegend(),
            ),
            Expanded(
              child: SeatGrid(),
            ),
            SeatActions(),
          ],
        ),
      ),
    );
  }
}
