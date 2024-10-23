import 'package:flutter/material.dart';
import '../models/events_model.dart';
import '../../core/services/events_read_service.dart';
import '../../core/services/events_write_service.dart';

class EventProvider with ChangeNotifier {
  final EventReadService _eventReadService = EventReadService();
  final EventWriteService _eventWriteService = EventWriteService();
  
  List<Event> _events = [];
  List<Event> get events => _events;
  String _filter = 'All';

  String get filter => _filter;

  Future<void> loadEvents() async {
    _events = await _eventReadService.fetchEvents();
    notifyListeners();
  }

  Future<void> createEvent(Event event) async {
    await _eventWriteService.createEvent(event);
    await loadEvents();
  }

  Future<void> updateEvent(Event event) async {
    await _eventWriteService.updateEvent(event);
    await loadEvents();
  }

  Future<void> deleteEvent(String id) async {
    await _eventWriteService.deleteEvent(id);
    await loadEvents();
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  List<Event> get filteredEvents {
    if (_filter == 'All') return _events;
    return _events.where((event) => event.eventType == _filter).toList();
  }
}
