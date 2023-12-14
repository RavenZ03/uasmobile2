import 'package:flutter/material.dart';
import 'db_manager.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({Key? key}) : super(key: key);

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> allTicketData = [];
  final TextEditingController stasiunAwalController = TextEditingController();
  final TextEditingController stasiunAkhirController = TextEditingController();
  final TextEditingController jamKeberangkatanController =
      TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _query();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Ticket Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (var item in allTicketData)
              Card(
                margin: EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Name: Pengguna ${item['name']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Stasiun Awal: ${item['stasiunawal']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Stasiun Akhir: ${item['stasiunakhir']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Jam Keberangkatan: ${item['jamkeberangkatan']}',
                        style: TextStyle(fontSize: 16),
                      ),
                      IconButton(
                          onPressed: () {
                            _delete(item['_id']);
                          },
                          icon: Icon(Icons.delete_outline)),
                      IconButton(
                          onPressed: () {
                            _selecedit(item['_id']);
                          },
                          icon: Icon(Icons.edit))
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
    setState(() {
      allTicketData = allRows;
    });
  }

  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
    _query();
  }

  void _selecedit(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsSelected = await dbHelper.selec(id);
    print('selectedit $rowsSelected');
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.question_mark),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text('Konfirmasi'),
          content: Column(children: [
            Text(
              'Stasiun Awal',
              style: TextStyle(fontSize: 18.0),
            ),
            TextFormField(
              controller: stasiunAwalController,
              decoration: InputDecoration(
                hintText: 'Masukkan Stasiun Awal',
              ),
              initialValue: rowsSelected[0]['stasiunawal'],
            ),
            SizedBox(height: 16.0),
            Text(
              'Stasiun Akhir',
              style: TextStyle(fontSize: 18.0),
            ),
            TextFormField(
              controller: stasiunAkhirController,
              decoration: InputDecoration(
                hintText: 'Masukkan Stasiun Akhir',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Jam Keberangkatan',
              style: TextStyle(fontSize: 18.0),
            ),
            TextFormField(
              controller: jamKeberangkatanController,
              decoration: InputDecoration(
                hintText: 'Masukkan Jam keberangkatan',
              ),
            ),
          ]),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Tutup')),
            ElevatedButton(
                onPressed: () {
                  print('Test');
                },
                child: Text('Simpan'))
          ],
        );
      },
    );
    // _query();
  }
}


// class MyApp extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TicketPage(),
//     );
//   }
// }

// class TicketPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ticket Page'),
//       ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       Text(
      //         'Your Ticket Details',
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       TicketInfoCard(),
      //     ],
      //   ),
      // ),
//     );
//   }
// }

// class TicketInfoCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
  //   return Card(
  //     margin: EdgeInsets.all(20),
  //     child: Padding(
  //       padding: EdgeInsets.all(20),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Text(
  //             'Name : ',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           Text(
  //             'Stasiun Awal : ',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           Text(
  //             'Stasiun Akhir : ',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //           Text(
  //             'Jam Keberangkatan :',
  //             style: TextStyle(fontSize: 16),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
//   void _query() async {
//     final allRows = await dbHelper.queryAllRowsTicket();
//     print('query all rows:');
//     allRows.forEach(print);
//     allTicketData = allRows;
//     setState(() {});
//   }
// }
