import 'package:flutter/material.dart';
class SelectSeatPage extends StatefulWidget {
  final List<String> bookedSeats;
  final int rowCount = 10; 
  final int columnCount = 8; 

  SelectSeatPage({required this.bookedSeats});

  @override
  _SelectSeatPageState createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Seats'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.columnCount,
          ),
          itemCount: widget.rowCount * widget.columnCount,
          itemBuilder: (context, index) {
            final rowNumber = String.fromCharCode(65 + (index ~/ widget.columnCount));
            final columnNumber = (index % widget.columnCount) + 1;
            final seatNumber = '$rowNumber$columnNumber';
            final isBooked = widget.bookedSeats.contains(seatNumber);
            final isSelected = selectedSeats.contains(seatNumber);
            final isAvailable = !isBooked;
      
            return 
      
       GestureDetector(
              onTap: isAvailable ? () => handleSeatSelection(seatNumber) : null,
              child: Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(color:isBooked ? Colors.grey : ( isSelected ? const Color.fromARGB(255, 1, 51, 27) : Colors.green)),
                  color: isBooked ? Colors.grey : (isSelected ? const Color.fromARGB(255, 1, 51, 27) : Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    seatNumber,
                    style: TextStyle(
                      color:isBooked?Colors.white:(isSelected? Colors.white:Colors.green),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void handleSeatSelection(String seatNumber) {
    setState(() {
      if (selectedSeats.contains(seatNumber)) {
        selectedSeats.remove(seatNumber);
      } else {
        selectedSeats.add(seatNumber);
      }
    });
  }
}

