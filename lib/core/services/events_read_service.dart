import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/models/events_model.dart';

class EventReadService {
  final String apiUrl = "https://getallevents-kxxktdtdjq-uc.a.run.app";

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

  Future<void> deleteEvent(String id) async {
    final response = await http.delete(Uri.parse('https://deleteevent-kxxktdtdjq-uc.a.run.app/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete event');
    }
  }
	
}
