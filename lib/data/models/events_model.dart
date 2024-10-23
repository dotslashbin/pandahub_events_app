class Event {
  final String id;
  final String title;
  final String description;
  final String organizer;
  final String eventType;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.organizer,
    required this.eventType,
  });

  // Factory method to create an event from JSON
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      organizer: json['organizer'],
      eventType: json['eventType'],
    );
  }

  // Convert event object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'organizer': organizer,
      'eventType': eventType,
    };
  }
}
