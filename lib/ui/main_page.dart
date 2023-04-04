import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../widget/body_list_view.dart';
import '../widget/nav_bar_profile.dart';
import '../widget/new_task_dialog.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String _dropdownButtonText = 'Select';

  @override
  Widget build(BuildContext context) {
    final titleTextController = TextEditingController();
    final descriptionTextController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    addTaskDialogBox() {
      showDialog(
          context: context,
          builder: (context) {
            return NewTaskDialog(
                selectedDate: selectedDate,
                titleTextController: titleTextController,
                descriptionTextController: descriptionTextController);
          });
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          toolbarHeight: 100,
          elevation: 4,
          title: Row(children: [
            Text('Diary',
                style:
                    TextStyle(color: Colors.blueGrey.shade400, fontSize: 40)),
            Text('Book',
                style: TextStyle(color: Colors.green.shade400, fontSize: 40))
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
              const NavBarProfile()
            ])
          ]),
      body: Row(children: [
        Expanded(
            child: Container(
                width: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Colors.blueGrey, width: 0.5))),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SfDateRangePicker(
                        onSelectionChanged:
                            (dateRangePickerSelectionChangedArgs) {
                          selectedDate =
                              dateRangePickerSelectionChangedArgs.value;
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Card(
                        elevation: 4,
                        child: TextButton.icon(
                          icon: const Icon(Icons.add,
                              size: 35, color: Colors.greenAccent),
                          label: Row(
                            children: const [
                              Text('Write New', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          onPressed: () {
                            addTaskDialogBox();
                          },
                        )),
                  )
                ]))),
        bodyListView()
      ]),
      floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          onPressed: () {
            addTaskDialogBox();
          },
          child: const Icon(Icons.add)),
    );
  }
}
