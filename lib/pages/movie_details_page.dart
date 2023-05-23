import 'package:flutter/material.dart';

import 'book_tickets_page.dart';

class MovieDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pichaikkaran 2'),
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                'https://moviegalleri.net/wp-content/uploads/2023/02/Actor-Vijay-Antony-Anti-Bikili-Pichaikkaran-2-Movie-Poster-HD.jpg',
                height: 200,
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(top:16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 const Row(children: [
                  Text(
                  '2h 28m',
                  style: TextStyle(fontSize: 12),
                ),
                DotWidget(),
                  
              Text(
                ' 19 May, 2023',
                style: TextStyle(fontSize: 12),
              ),
                ],),
               
                   
            
                   
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookTicketsPage()),
                  );
                },
                style:  ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 177, 31, 21)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                   
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Book Tickets',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                ),
              ),],),
          )
           
          ],
        ),
      ),
    );
  }
}


class DotWidget extends StatelessWidget {
  const DotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5,
      height: 5,
      margin: const EdgeInsets.only(left: 5,right: 5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.black,
      ),
    );
  }
}
