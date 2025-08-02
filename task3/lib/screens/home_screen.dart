import 'package:flutter/material.dart';
import 'dart:async';
import '../models/alarm.dart';
import '../services/alarm_service.dart';
import '../utils/time_formatter.dart';
import '../theme/app_theme.dart';
import '../widgets/alarm_tile.dart';
import '../widgets/alarm_ringing_dialog.dart';
import 'alarm_setting_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();
  final AlarmService _alarmService = AlarmService();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });

    _alarmService.onAlarmTriggered = (alarm) {
      _showAlarmDialog(alarm);
    };
  }

  @override
  void dispose() {
    _timer.cancel();
    _alarmService.dispose();
    super.dispose();
  }

  void _showAlarmDialog(Alarm alarm) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlarmRingingDialog(
          alarm: alarm,
          onSnooze: () => _handleSnooze(alarm),
          onDismiss: () => _handleDismiss(alarm),
        );
      },
    );
  }

  void _handleSnooze(Alarm alarm) {
    _alarmService.snoozeAlarm(alarm.id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Alarm snoozed for 5 minutes'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _handleDismiss(Alarm alarm) {
    // Just close the dialog - alarm will ring again tomorrow at the same time
  }

  void _navigateToAlarmSetting() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AlarmSettingScreen()),
    );
    setState(() {}); // Refresh the alarm list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Alarm Clock',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: Column(
          children: [
            SizedBox(height: 36 ),
            Text ( ' Mohit Bawankar ' , style: TextStyle(fontSize: 36),) ,
            _buildCurrentTimeDisplay(),
            _buildAddAlarmButton(),
            _buildAlarmsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentTimeDisplay() {
    return Expanded(
      flex: 2,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              TimeFormatter.formatTime(_currentTime),
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 8),
            Text(
              TimeFormatter.formatDate(_currentTime),
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddAlarmButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          onPressed: _navigateToAlarmSetting,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 28),
              SizedBox(width: 8),
              Text(
                'Set New Alarm',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlarmsList() {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.all(20),
        decoration: AppTheme.cardDecoration(),
        child: Column(
          children: [
            _buildAlarmsHeader(),
            Expanded(
              child: _alarmService.alarms.isEmpty
                  ? _buildEmptyAlarmsState()
                  : _buildAlarmsListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlarmsHeader() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Your Alarms',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '${_alarmService.alarms.length}',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyAlarmsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.alarm_off, size: 64, color: Colors.white30),
          SizedBox(height: 16),
          Text(
            'No alarms set',
            style: TextStyle(fontSize: 18, color: Colors.white30),
          ),
        ],
      ),
    );
  }

  Widget _buildAlarmsListView() {
    return ListView.builder(
      itemCount: _alarmService.alarms.length,
      itemBuilder: (context, index) {
        final alarm = _alarmService.alarms[index];
        return AlarmTile(
          alarm: alarm,
          onToggle: () {
            setState(() {
              _alarmService.toggleAlarm(alarm.id);
            });
          },
          onDelete: () {
            setState(() {
              _alarmService.removeAlarm(alarm.id);
            });
          },
        );
      },
    );
  }
}