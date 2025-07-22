import 'package:flutter/material.dart';

class Alarm {
  String id;
  TimeOfDay time;
  String tone;
  bool isEnabled;
  String label;

  Alarm({
    required this.id,
    required this.time,
    this.tone = 'Default',
    this.isEnabled = true,
    this.label = 'Alarm',
  });

  // Convert to JSON for potential future storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hour': time.hour,
      'minute': time.minute,
      'tone': tone,
      'isEnabled': isEnabled,
      'label': label,
    };
  }

  // Create from JSON
  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      id: json['id'],
      time: TimeOfDay(hour: json['hour'], minute: json['minute']),
      tone: json['tone'] ?? 'Default',
      isEnabled: json['isEnabled'] ?? true,
      label: json['label'] ?? 'Alarm',
    );
  }
}