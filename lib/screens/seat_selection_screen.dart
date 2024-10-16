import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seat_selection_app/providers/seat_provider.dart';

class SeatSelectionScreen extends StatelessWidget {
  const SeatSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final seatProvider = Provider.of<SeatProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Selection'),
      ),
       body: seatProvider.isLoading
           ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: seatProvider.selectedTripType,
                    items: seatProvider.tripTypes
                        .map((type) =>
                            DropdownMenuItem(value: type, child: Text(type)))
                        .toList(),
                    onChanged: (value) => seatProvider.setTripType(value!),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: seatProvider.selectedTripDate,
                    items: seatProvider.tripDates
                        .map((date) =>
                            DropdownMenuItem(value: date, child: Text(date)))
                        .toList(),
                    onChanged: (value) => seatProvider.setTripDate(value!),
                  ),
                ),
                const Text('Select Seat'),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                    ),
                    itemCount: seatProvider.seats.length,
                    itemBuilder: (context, index) {
                      final seat = seatProvider.seats[index];
                      return GestureDetector(
                        onTap: () => seatProvider.toggleSeatSelection(seat),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: seat['status'] == 'occupied'
                                ? Colors.red
                                : seat['isSelected']
                                    ? Colors.green
                                    : Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text('${seatProvider.selectedSeatsCount} Selected'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: seatProvider.confirmSelection,
                      child: const Text('Confirm'),
                    ),
                    OutlinedButton(
                      onPressed: seatProvider.cancelSelection,
                      child: const Text('Cancel'),
                    ),
                  ],
                )
              ],
            ),
    );
  }
}
