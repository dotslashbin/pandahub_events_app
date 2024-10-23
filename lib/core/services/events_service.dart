import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/events_model.dart';

class EventService {
  final String apiUrl = "https://getallevents-kxxktdtdjq-uc.a.run.app";  // Replace with your API

  Future<List<Event>> fetchEvents() async {

    try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      // Decode the entire JSON response
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      
      // Extract the list of events from the 'data' field
      List<dynamic> eventData = jsonResponse['data'];
      
      // Convert each event in the list to an Event object

      return eventData.map((json) => Event.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load events');
    }
  } catch (e) {
    print('Error during API call: $e');
    throw Exception('Error during API call: $e');
  }
  }

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
