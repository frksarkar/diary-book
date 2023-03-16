import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _dropdownButtonText = 'Select';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          toolbarHeight: 100,
          elevation: 4,
          title: Row(children: [
            Text('Diary', style: TextStyle(color: Colors.blueGrey.shade400)),
            Text('Book', style: TextStyle(color: Colors.green.shade400))
          ]),
          actions: [
            Row(children: [
              DropdownButton(
                items: ['Latest', 'Earliest'].map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                hint: Text(_dropdownButtonText),
                onChanged: (value) {
                  if (value == 'Latest') {
                    setState(() {
                      _dropdownButtonText = value.toString();
                    });
                  } else if (value == 'Earliest') {
                    setState(() {
                      _dropdownButtonText = value.toString();
                    });
                  }
                },
              ),
              //TODO: create profile
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: InkWell(
                            onTap: () {},
                            child: const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    'https://loremflickr.com/g/320/240/paris,girl/all'),
                                radius: 30),
                          ),
                        ),
                        const Text('John dho',
                            style: TextStyle(color: Colors.grey, fontSize: 18))
                      ]),
                  IconButton(
                      icon: const Icon(Icons.logout, color: Colors.red),
                      onPressed: () {})
                ]),
              )
            ])
          ]),
      body: Row(children: [
        Expanded(
            child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.blueGrey, width: 0.5))),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SfDateRangePicker(
                        onSelectionChanged:
                            (dateRangePickerSelectionChangedArgs) {},
                      )),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Card(
                        elevation: 4,
                        child: TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add,
                                size: 35, color: Colors.greenAccent),
                            label: Row(
                              children: const [
                                Text('Write New',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ))),
                  )
                ]))),
        Expanded(flex: 3, child: Container(color: Colors.white))
      ]),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add', onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}
