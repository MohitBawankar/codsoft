// import 'package:flutter/material.dart';
// import 'dart:async';
//
// void main() {
//   runApp(AlarmClockApp());
// }
//
// class AlarmClockApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Alarm Clock',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: Color(0xFF0A0E27),
//         appBarTheme: AppBarTheme(
//           backgroundColor: Color(0xFF1A1D3A),
//           elevation: 0,
//         ),
//       ),
//       home: HomeScreen(),
//     );
//   }
// }
//
// class Alarm {
//   String id;
//   TimeOfDay time;
//   String tone;
//   bool isEnabled;
//   String label;
//
//   Alarm({
//     required this.id,
//     required this.time,
//     this.tone = 'Default',
//     this.isEnabled = true,
//     this.label = 'Alarm',
//   });
// }
//
// class AlarmService {
//   static final AlarmService _instance = AlarmService._internal();
//   factory AlarmService() => _instance;
//   AlarmService._internal();
//
//   List<Alarm> _alarms = [];
//   Timer? _checkTimer;
//   Function(Alarm)? onAlarmTriggered;
//
//   List<Alarm> get alarms => _alarms;
//
//   void addAlarm(Alarm alarm) {
//     _alarms.add(alarm);
//     _startChecking();
//   }
//
//   void removeAlarm(String id) {
//     _alarms.removeWhere((alarm) => alarm.id == id);
//     if (_alarms.isEmpty) {
//       _checkTimer?.cancel();
//     }
//   }
//
//   void toggleAlarm(String id) {
//     final alarm = _alarms.firstWhere((a) => a.id == id);
//     alarm.isEnabled = !alarm.isEnabled;
//     if (_alarms.any((a) => a.isEnabled)) {
//       _startChecking();
//     } else {
//       _checkTimer?.cancel();
//     }
//   }
//
//   void _startChecking() {
//     _checkTimer?.cancel();
//     _checkTimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       final now = DateTime.now();
//       final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
//
//       for (final alarm in _alarms) {
//         if (alarm.isEnabled &&
//             alarm.time.hour == currentTime.hour &&
//             alarm.time.minute == currentTime.minute &&
//             now.second == 0) {
//           onAlarmTriggered?.call(alarm);
//         }
//       }
//     });
//   }
//
//   void dispose() {
//     _checkTimer?.cancel();
//   }
// }
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late Timer _timer;
//   DateTime _currentTime = DateTime.now();
//   final AlarmService _alarmService = AlarmService();
//
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
//       setState(() {
//         _currentTime = DateTime.now();
//       });
//     });
//
//     _alarmService.onAlarmTriggered = (alarm) {
//       _showAlarmDialog(alarm);
//     };
//   }
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     _alarmService.dispose();
//     super.dispose();
//   }
//
//   void _showAlarmDialog(Alarm alarm) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlarmRingingDialog(alarm: alarm);
//       },
//     );
//   }
//
//   String _formatTime(DateTime time) {
//     return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
//   }
//
//   String _formatDate(DateTime date) {
//     final months = [
//       'January', 'February', 'March', 'April', 'May', 'June',
//       'July', 'August', 'September', 'October', 'November', 'December'
//     ];
//     final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
//
//     return "${days[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}, ${date.year}";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Alarm Clock', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF0A0E27), Color(0xFF1A1D3A)],
//           ),
//         ),
//         child: Column(
//           children: [
//             // Current Time Display
//             Expanded(
//               flex: 2,
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       _formatTime(_currentTime),
//                       style: TextStyle(
//                         fontSize: 64,
//                         fontWeight: FontWeight.w300,
//                         color: Colors.white,
//                         letterSpacing: 2,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       _formatDate(_currentTime),
//                       style: TextStyle(
//                         fontSize: 18,
//                         color: Colors.white70,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // Add Alarm Button
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 60,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => AlarmSettingScreen()),
//                     ).then((_) => setState(() {}));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF4A90E2),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.add, size: 28),
//                       SizedBox(width: 8),
//                       Text('Set New Alarm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//
//             // Alarms List
//             Expanded(
//               flex: 2,
//               child: Container(
//                 margin: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF1A1D3A),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(20.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Your Alarms',
//                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                           ),
//                           Text(
//                             '${_alarmService.alarms.length}',
//                             style: TextStyle(fontSize: 16, color: Colors.white70),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: _alarmService.alarms.isEmpty
//                           ? Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.alarm_off, size: 64, color: Colors.white30),
//                             SizedBox(height: 16),
//                             Text(
//                               'No alarms set',
//                               style: TextStyle(fontSize: 18, color: Colors.white30),
//                             ),
//                           ],
//                         ),
//                       )
//                           : ListView.builder(
//                         itemCount: _alarmService.alarms.length,
//                         itemBuilder: (context, index) {
//                           final alarm = _alarmService.alarms[index];
//                           return AlarmTile(
//                             alarm: alarm,
//                             onToggle: () {
//                               setState(() {
//                                 _alarmService.toggleAlarm(alarm.id);
//                               });
//                             },
//                             onDelete: () {
//                               setState(() {
//                                 _alarmService.removeAlarm(alarm.id);
//                               });
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class AlarmTile extends StatelessWidget {
//   final Alarm alarm;
//   final VoidCallback onToggle;
//   final VoidCallback onDelete;
//
//   const AlarmTile({
//     Key? key,
//     required this.alarm,
//     required this.onToggle,
//     required this.onDelete,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       decoration: BoxDecoration(
//         color: alarm.isEnabled ? Color(0xFF2A2D4A) : Color(0xFF1A1D3A),
//         borderRadius: BorderRadius.circular(12),
//         border: alarm.isEnabled ? Border.all(color: Color(0xFF4A90E2), width: 1) : null,
//       ),
//       child: ListTile(
//         leading: Icon(
//           alarm.isEnabled ? Icons.alarm : Icons.alarm_off,
//           color: alarm.isEnabled ? Color(0xFF4A90E2) : Colors.white30,
//           size: 28,
//         ),
//         title: Text(
//           alarm.time.format(context),
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.w500,
//             color: alarm.isEnabled ? Colors.white : Colors.white30,
//           ),
//         ),
//         subtitle: Text(
//           '${alarm.label} • ${alarm.tone}',
//           style: TextStyle(
//             color: alarm.isEnabled ? Colors.white70 : Colors.white30,
//           ),
//         ),
//         trailing: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Switch(
//               value: alarm.isEnabled,
//               onChanged: (_) => onToggle(),
//               activeColor: Color(0xFF4A90E2),
//             ),
//             IconButton(
//               icon: Icon(Icons.delete, color: Colors.red),
//               onPressed: onDelete,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class AlarmSettingScreen extends StatefulWidget {
//   @override
//   _AlarmSettingScreenState createState() => _AlarmSettingScreenState();
// }
//
// class _AlarmSettingScreenState extends State<AlarmSettingScreen> {
//   TimeOfDay _selectedTime = TimeOfDay.now();
//   String _selectedTone = 'Default';
//   String _label = 'Alarm';
//   final TextEditingController _labelController = TextEditingController();
//
//   final List<String> _tones = [
//     'Default',
//     'Bell',
//     'Chime',
//     'Digital',
//     'Rooster',
//     'Buzzer',
//     'Melody'
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _labelController.text = _label;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Set Alarm'),
//         actions: [
//           TextButton(
//             onPressed: _saveAlarm,
//             child: Text(
//               'SAVE',
//               style: TextStyle(color: Color(0xFF4A90E2), fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF0A0E27), Color(0xFF1A1D3A)],
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             children: [
//               // Time Picker
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF1A1D3A),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   children: [
//                     Text(
//                       'Set Time',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     SizedBox(height: 20),
//                     GestureDetector(
//                       onTap: _selectTime,
//                       child: Container(
//                         padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
//                         decoration: BoxDecoration(
//                           color: Color(0xFF4A90E2),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           _selectedTime.format(context),
//                           style: TextStyle(fontSize: 36, fontWeight: FontWeight.w300, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//               // Label Input
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF1A1D3A),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Label',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     SizedBox(height: 12),
//                     TextField(
//                       controller: _labelController,
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Color(0xFF2A2D4A),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                           borderSide: BorderSide.none,
//                         ),
//                         hintText: 'Enter alarm label',
//                         hintStyle: TextStyle(color: Colors.white54),
//                       ),
//                       onChanged: (value) {
//                         setState(() {
//                           _label = value.isEmpty ? 'Alarm' : value;
//                         });
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//
//               SizedBox(height: 20),
//
//               // Tone Selection
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Color(0xFF1A1D3A),
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Alarm Tone',
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     SizedBox(height: 12),
//                     Container(
//                       height: 150,
//                       child: ListView.builder(
//                         itemCount: _tones.length,
//                         itemBuilder: (context, index) {
//                           final tone = _tones[index];
//                           return ListTile(
//                             title: Text(tone, style: TextStyle(color: Colors.white)),
//                             leading: Radio<String>(
//                               value: tone,
//                               groupValue: _selectedTone,
//                               onChanged: (String? value) {
//                                 setState(() {
//                                   _selectedTone = value!;
//                                 });
//                               },
//                               activeColor: Color(0xFF4A90E2),
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 _selectedTone = tone;
//                               });
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _selectTime() async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime,
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.dark(
//               primary: Color(0xFF4A90E2),
//               surface: Color(0xFF1A1D3A),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != _selectedTime) {
//       setState(() {
//         _selectedTime = picked;
//       });
//     }
//   }
//
//   void _saveAlarm() {
//     final alarm = Alarm(
//       id: DateTime.now().millisecondsSinceEpoch.toString(),
//       time: _selectedTime,
//       tone: _selectedTone,
//       label: _label,
//     );
//
//     AlarmService().addAlarm(alarm);
//     Navigator.pop(context);
//   }
// }
//
// class AlarmRingingDialog extends StatefulWidget {
//   final Alarm alarm;
//
//   const AlarmRingingDialog({Key? key, required this.alarm}) : super(key: key);
//
//   @override
//   _AlarmRingingDialogState createState() => _AlarmRingingDialogState();
// }
//
// class _AlarmRingingDialogState extends State<AlarmRingingDialog>
//     with TickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: Duration(seconds: 1),
//       vsync: this,
//     )..repeat(reverse: true);
//
//     _scaleAnimation = Tween<double>(
//       begin: 0.8,
//       end: 1.2,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Color(0xFF1A1D3A),
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(color: Colors.red, width: 2),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             AnimatedBuilder(
//               animation: _scaleAnimation,
//               builder: (context, child) {
//                 return Transform.scale(
//                   scale: _scaleAnimation.value,
//                   child: Icon(
//                     Icons.alarm,
//                     size: 80,
//                     color: Colors.red,
//                   ),
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             Text(
//               'ALARM',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               widget.alarm.time.format(context),
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.w300,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               widget.alarm.label,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.white70,
//               ),
//             ),
//             SizedBox(height: 30),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       // Implement snooze logic (5 minutes later)
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text('Alarm snoozed for 5 minutes'),
//                           backgroundColor: Colors.orange,
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.orange,
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text('SNOOZE', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     child: Text('DISMISS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(AlarmClockApp());
}

class AlarmClockApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm Clock',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: HomeScreen(),
    );
  }
}