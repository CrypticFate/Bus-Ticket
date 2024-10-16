import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SeatProvider with ChangeNotifier {
  final _database = FirebaseDatabase.instance.ref();
  bool isLoading = true;
  List<Map<String, dynamic>> seats = [];
  String selectedTripType = 'Bus';
  String selectedTripDate = 'Today';
  int selectedSeatsCount = 0;

  List<String> tripTypes = ['One Way','Round Trip'];
  List<String> tripDates = ['Today', 'Tomorrow'];

  SeatProvider() {
    loadSeats();
  }

  void loadSeats() async {
    isLoading = true;
    notifyListeners();

    try {
      // Fetch seats for selected trip type and date (mock data for now)
      const tripId = 'tripId1'; // Mock trip ID
      final seatSnapshot = await _database.child('seats/$tripId').once();
      final seatData = seatSnapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (seatData != null) {
        seats = seatData.entries.map((entry) {
          return {
            'id': entry.key,
            'status': entry.value['status'],
            'isSelected': false,
          };
        }).toList();
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error loading seats: $e');
      isLoading = false;
      notifyListeners();
    }
  }

  void setTripType(String type) {
    selectedTripType = type;
    loadSeats();
  }

  void setTripDate(String date) {
    selectedTripDate = date;
    loadSeats();
  }

  void toggleSeatSelection(Map<String, dynamic> seat) {
    if (seat['status'] == 'available') {
      seat['isSelected'] = !seat['isSelected'];
      selectedSeatsCount = seats.where((seat) => seat['isSelected']).length;
      notifyListeners();
    }
  }

  void confirmSelection() async {
    const userId = 'userId123'; // Mock user ID
    const tripId = 'tripId1'; // Mock trip ID

    // Check if user already selected a seat
    final userSnapshot =
        await _database.child('users/$userId').child('selectedSeat').once();
    if (userSnapshot.snapshot.value != null) {
      // User has already selected a seat
      print('You have already selected a seat.');
      return;
    }

    final selectedSeats = seats.where((seat) => seat['isSelected']);
    if (selectedSeats.isEmpty) return;

    final selectedSeat = selectedSeats.first;

    // Update seat status in the database
    await _database
        .child('seats/$tripId/${selectedSeat['id']}')
        .update({'status': 'occupied', 'user': userId});

    // Update user's seat selection
    await _database.child('users/$userId').set({
      'selectedSeat': selectedSeat['id'],
      'tripId': tripId,
    });

    print('Seat selection confirmed.');
  }

  void cancelSelection() {
    for (var seat in seats) {
      seat['isSelected'] = false;
    }
    selectedSeatsCount = 0;
    notifyListeners();
  }
}
