import 'package:astronomy_flutter/screens/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:astronomy_flutter/api/apod_api.dart';
import 'package:astronomy_flutter/models/apod_model.dart';

class Apod extends StatefulWidget {
  const Apod({Key? key}) : super(key: key);

  @override
  State<Apod> createState() => _ApodState();
}

class _ApodState extends State<Apod> {
  PicsApi productApi = PicsApi();
  PictureOfTheDayModel? picture;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getPics();
  }

  DateTime _dateChosen = DateTime.now();

  getPics() async {
    setState(() {
      isLoading = true;
    });

    String formattedDate = _dateChosen.toLocal().toString().split(' ')[0];

    try {
      picture = await productApi.fetchProductByDate(formattedDate);
    } catch (e) {
      print("Error: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _dateChosen,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          // Set the time part to 00:00:00 to retain only the date
          _dateChosen = DateTime(value.year, value.month, value.day);
          getPics();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Center(
          child: Text(
            'Astronomy Picture of the Day',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: const Navbar(),
      body: ListView(
        children: [
          isLoading
              ? const SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 0, 36, 57)),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 20.0, 2.0, 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Card(
                      color: const Color.fromARGB(255, 0, 36, 57),
                      child: Expanded(
                        child: picture != null
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    12.0, 12.0, 12.0, 12.0),
                                child: Column(children: [
                                  Text(
                                    picture!.title,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Image.network(picture!.url),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SingleChildScrollView(
                                    child: Text(picture!.explanation,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal)),
                                  ),
                                ]),
                              )
                            : const Center(
                                child: Text("No data available."),
                              ),
                      ),
                    ),
                  ),
                ),
          MaterialButton(
            onPressed: _showDatePicker,
            color: const Color.fromARGB(255, 0, 36, 57),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.calendar_month),
                    Text(
                      "Date Picker",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: Apod(),
  ));
}
