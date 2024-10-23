import 'package:flutter/material.dart';
import '../data/models/events_model.dart';

class EventForm extends StatefulWidget {
  final Event? event;
  final Function(Event) onSave;

  const EventForm({Key? key, this.event, required this.onSave}) : super(key: key);

  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final _formKey = GlobalKey<FormState>();
  late String title;
  // late String date;
  late String organizer;
  late String eventType;

  @override
  void initState() {
    super.initState();
    title = widget.event?.title ?? '';
    // date = widget.event?.date ?? '';
    organizer = widget.event?.organizer ?? '';
    eventType = widget.event?.eventType ?? 'Conference';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.event == null ? 'Create Event' : 'Edit Event'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: title,
              decoration: InputDecoration(labelText: 'Title'),
              onSaved: (value) => title = value!,
              validator: (value) => value!.isEmpty ? 'Please enter title' : null,
            ),
            // TextFormField(
            //   initialValue: date,
            //   decoration: InputDecoration(labelText: 'Date'),
            //   onSaved: (value) => date = value!,
            //   validator: (value) => value!.isEmpty ? 'Please enter date' : null,
            // ),
            TextFormField(
              initialValue: organizer,
              decoration: InputDecoration(labelText: 'Organizer'),
              onSaved: (value) => organizer = value!,
              validator: (value) => value!.isEmpty ? 'Please enter organizer' : null,
            ),
            DropdownButtonFormField<String>(
              value: eventType,
              items: ['Conference', 'Workshop', 'Seminar']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => eventType = value!),
              onSaved: (value) => eventType = value!,
              decoration: InputDecoration(labelText: 'Event Type'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onSave(Event(
                id: widget.event?.id ?? '',
                title: title,
                description: 'this is description',
                organizer: organizer,
                eventType: eventType,
              ));
              Navigator.of(context).pop();
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
