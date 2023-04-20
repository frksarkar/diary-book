import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Expanded left_calendar(
    BuildContext context, DateTime selectedDate, Null addTaskDialogBox()) {
  return Expanded(
      child: Container(
          width: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              border: Border(
                  right: BorderSide(color: Colors.blueGrey, width: 0.5))),
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: SfDateRangePicker(
                  onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                    selectedDate = dateRangePickerSelectionChangedArgs.value;
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
          ])));
}
