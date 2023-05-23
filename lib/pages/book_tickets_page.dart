import 'package:bookmyshow/pages/select_seat_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
class BookTicketsPage extends StatefulWidget {
  @override
  _BookTicketsPageState createState() => _BookTicketsPageState();
}

class _BookTicketsPageState extends State<BookTicketsPage> with SingleTickerProviderStateMixin {
  List<DateData> datesData = []; 
  int selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
   
    // datesData = [
    //   DateData(
    //     date: 'May 22, 2023',
    //     theaters: [
    //       TheaterData(name: 'AGS Cinemas OMR: Navlur', timeSlots: ['10:00 AM', '2:00 PM', '6:00 PM']),
    //       TheaterData(name: 'AGS Cinemas: Maduravoyal', timeSlots: ['11:00 AM', '3:00 PM', '7:00 PM']),
    //     ],
    //   ),
    //   DateData(
    //     date: 'May 23, 2023',
    //     theaters: [
    //       TheaterData(name: 'Theater C', timeSlots: ['9:00 AM', '1:00 PM', '5:00 PM']),
    //       TheaterData(name: 'Theater D', timeSlots: ['10:30 AM', '2:30 PM', '6:30 PM']),
    //     ],
    //   ),
    //     DateData(
    //     date: 'May 24, 2023',
    //     theaters: [
    //       TheaterData(name: 'Theater C', timeSlots: ['9:00 AM', '1:00 PM', '5:00 PM']),
    //       TheaterData(name: 'Theater D', timeSlots: ['10:30 AM', '2:30 PM', '6:30 PM']),
    //     ],
    //   ),
    // ];
fetchDatesData();
    _tabController = TabController(length: datesData.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _scrollToIndex(int index) {
    if (index >= 0 && index < datesData.length) {
     
      _tabController.animateTo(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
   void fetchDatesData() {

    const jsonString = '''
      [
          {
          "date": "May 21, 2023",
          "theaters": [
            {
              "name": "AGS Cinemas OMR: Navlur",
              "timeSlots": ["10:00 AM", "2:00 PM", "6:00 PM"],
               "bookedSeats": ["A1", "B2"]
            },
            {
              "name": "AGS Cinemas: Maduravoyal",
              "timeSlots": ["11:00 AM", "3:00 PM", "7:00 PM"],
               "bookedSeats": []
            }
          ]
        },
        {
          "date": "May 22, 2023",
          "theaters": [
            {
              "name": "AGS Cinemas OMR: Navlur",
              "timeSlots": ["10:00 AM", "2:00 PM", "6:00 PM"],
               "bookedSeats": ["A1"]
            },
            {
              "name": "AGS Cinemas: Maduravoyal",
              "timeSlots": ["11:00 AM", "3:00 PM", "7:00 PM"],
               "bookedSeats": ["A1", "B2"]
            },
            {
              "name": "AGS Cinemas: T.Nagar",
              "timeSlots": ["11:00 AM", "3:00 PM", "7:00 PM"],
               "bookedSeats": ["B2"]
            }
          ]
        },
        {
          "date": "May 23, 2023",
          "theaters": [
            {
              "name": "AGS Cinemas: Villivakkam",
              "timeSlots": ["9:00 AM", "1:00 PM", "5:00 PM"],
               "bookedSeats": ["A1", "B2"]
            },
            {
              "name": "Anna Cinemas: Mount Road",
              "timeSlots": ["10:30 AM", "2:30 PM", "6:30 PM"],
               "bookedSeats": ["A1", "B2"]
            }
          ]
        }
      ]
    ''';

   final jsonData = jsonDecode(jsonString);

    setState(() {
      datesData = List<DateData>.from(jsonData.map((data) => DateData(
        date: data['date'],
        theaters: List<TheaterData>.from(data['theaters'].map((theater) => TheaterData(
          name: theater['name'],
          timeSlots: List<String>.from(theater['timeSlots']),
          bookedSeats: List<String>.from(theater['bookedSeats']),
        ))),
      )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pichaikkaran 2 - Tamil'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Row(
            children: [
               IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _scrollToIndex(selectedIndex - 1);
                },
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width/1.5,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: datesData.length,
                  itemBuilder: (context, index) {
                    final date = datesData[index].date;
                    final isSelected = selectedIndex == index;
                    final containerColor = isSelected ? Colors.red : Colors.transparent;
                    final textColor = isSelected ? Colors.white : Colors.black;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                        _scrollToIndex(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        color: containerColor,
                        child: Text(
                          date,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
               IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  _scrollToIndex(selectedIndex + 1);
                },
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: datesData.map((dateData) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: dateData.theaters.map((theater) {
                    return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(theater.name),
                        const SizedBox(height: 4),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: theater.timeSlots.length,
                                        itemBuilder: (context, index) {
                                          final timeSlot = theater.timeSlots[index];
                                          return InkWell(
                                            onTap: (){
 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SelectSeatPage(bookedSeats: theater.bookedSeats,)),
                  );
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                                    border: Border.all(color: Colors.green),
                                                                    borderRadius: BorderRadius.circular(8),
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child: Center(
                                                child: Text(
                                                                      timeSlot,
                                                                      style: const TextStyle(
                                                                        color: Colors.green,
                                                                        fontWeight: FontWeight.bold,
                                                                      ),
                                                ),
                                              ),
                                            ),
                                          );
                                          
                                          
                                        },
                                        
                                        
                                      ),
                        ),
                      Divider()
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}



class DateData {
  final String date;
  final List<TheaterData> theaters;

  DateData({required this.date, required this.theaters});
}

class TheaterData {
  final String name;
  final List<String> timeSlots;
 final List<String> bookedSeats;
  TheaterData({required this.name, required this.timeSlots, required this.bookedSeats,});
}