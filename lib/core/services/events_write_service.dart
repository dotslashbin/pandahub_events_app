import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/events_model.dart';

class EventWriteService {
  final String apiUrl = "https://getallevents-kxxktdtdjq-uc.a.run.app";  

  Future<void> createEvent(Event event) async {
    final response = await http.post(
      Uri.parse('https://createevent-kxxktdtdjq-uc.a.run.app'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(event.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create event');
    }
  }

  Future<void> updateEvent(Event event) async {
    final response = await http.put(
      Uri.parse('https://updateevent-kxxktdtdjq-uc.a.run.app/${event.id}'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(event.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update event');
    }
  }

  Future<void> deleteEvent(String id) async {
    final response = await http.delete(Uri.parse('https://deleteevent-kxxktdtdjq-uc.a.run.app/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete event');
    }
  }
	
}
