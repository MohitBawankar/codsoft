import 'dart:async';
import 'package:flutter/material.dart';
import '../models/alarm.dart';

class AlarmService {
  static final AlarmService _instance = AlarmService._internal();
  factory AlarmService() => _instance;
  AlarmService._internal();

  List<Alarm> _alarms = [];
  Timer? _checkTimer;
  Function(Alarm)? onAlarmTriggered;

  List<Alarm> get alarms => List.unmodifiable(_alarms);

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
    _startChecking();
  }

  void removeAlarm(String id) {
    _alarms.removeWhere((alarm) => alarm.id == id);
    if (_alarms.isEmpty) {
      _checkTimer?.cancel();
    }
  }

  void updateAlarm(Alarm updatedAlarm) {
    final index = _alarms.indexWhere((alarm) => alarm.id == updatedAlarm.id);
    if (index != -1) {
      _alarms[index] = updatedAlarm;
    }
  }

  void toggleAlarm(String id) {
    final alarmIndex = _alarms.indexWhere((a) => a.id == id);
    if (alarmIndex != -1) {
      _alarms[alarmIndex].isEnabled = !_alarms[alarmIndex].isEnabled;
      if (_alarms.any((a) => a.isEnabled)) {
        _startChecking();
      } else {
        _checkTimer?.cancel();
      }
    }
  }

  void _startChecking() {
    _checkTimer?.cancel();
    _checkTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);

      for (final alarm in _alarms) {
        if (alarm.isEnabled &&
            alarm.time.hour == currentTime.hour &&
            alarm.time.minute == currentTime.minute &&
            now.second == 0) {
          onAlarmTriggered?.call(alarm);
        }
      }
    });
  }

  void snoozeAlarm(String id, {int minutes = 5}) {
    final alarmIndex = _alarms.indexWhere((a) => a.id == id);
    if (alarmIndex != -1) {
      final alarm = _alarms[alarmIndex];
      final now = DateTime.now();
      final snoozeTime = now.add(Duration(minutes: minutes));
      
      // Create a temporary snooze alarm
      final snoozeAlarm = Alarm(
        id: '${alarm.id}snooze${now.millisecondsSinceEpoch}',
        time: TimeOfDay(hour: snoozeTime.hour, minute: snoozeTime.minute),
        tone: alarm.tone,
        label: '${alarm.label} (Snoozed)',
        isEnabled: true,
      );
      
      addAlarm(snoozeAlarm);
    }
  }

  void dispose() {
    _checkTimer?.cancel();
  }
}