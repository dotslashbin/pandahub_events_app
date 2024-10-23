import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/providers/event_provider.dart';
import '../data/models/events_model.dart';
import './event_form.dart';

class EventListScreen extends StatefulWidget {
  @override
  _EventListScreenState createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  late Future<void> _fetchEventsFuture;  // Cache the future

  @override
  void initState() {
    super.initState();
    // Call the API once and cache the Future
    _fetchEventsFuture = Provider.of<EventProvider>(context, listen: false).loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openEventForm(context),
          ),
          _buildFilterDropdown(eventProvider),
        ],
      ),
      body: FutureBuilder(
        future: _fetchEventsFuture,  // Use the cached Future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load events'));
          }
          return _buildEventList(eventProvider);
        },
      ),
    );
  }

  Widget _buildEventList(EventProvider provider) {
    return ListView.builder(
      itemCount: provider.filteredEvents.length,
      itemBuilder: (context, index) {
        final event = provider.filteredEvents[index];
        return ListTile(
          title: Text(event.title),
          subtitle: Text('Organizer: ${event.organizer}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => _openEventForm(context, event: event),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => provider.deleteEvent(event.id),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openEventForm(BuildContext context, {Event? event}) {
    showDialog(
      context: context,
      builder: (_) => EventForm(
        event: event,
        onSave: (newEvent) {
          if (event == null) {
            Provider.of<EventProvider>(context, listen: false).createEvent(newEvent);
          } else {
            Provider.of<EventProvider>(context, listen: false).updateEvent(newEvent);
          }
        },
      ),
    );
  }

  Widget _buildFilterDropdown(EventProvider provider) {
    return DropdownButton<String>(
      value: provider.filter,
      items: ['All', 'Conference', 'Workshop', 'Seminar']
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (value) => provider.setFilter(value!),
    );
  }
}
