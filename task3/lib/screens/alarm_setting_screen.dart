import 'package:flutter/material.dart';
import '../models/alarm.dart';
import '../services/alarm_service.dart';
import '../theme/app_theme.dart';

class AlarmSettingScreen extends StatefulWidget {
  final Alarm? existingAlarm;

  const AlarmSettingScreen({Key? key, this.existingAlarm}) : super(key: key);

  @override
  _AlarmSettingScreenState createState() => _AlarmSettingScreenState();
}

class _AlarmSettingScreenState extends State<AlarmSettingScreen> {
  late TimeOfDay _selectedTime;
  late String _selectedTone;
  late String _label;
  late TextEditingController _labelController;

  final List<String> _availableTones = [
    'Default',
    'Bell',
    'Chime',
    'Digital',
    'Rooster',
    'Buzzer',
    'Melody'
  ];

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    if (widget.existingAlarm != null) {
      _selectedTime = widget.existingAlarm!.time;
      _selectedTone = widget.existingAlarm!.tone;
      _label = widget.existingAlarm!.label;
    } else {
      _selectedTime = TimeOfDay.now();
      _selectedTone = _availableTones.first;
      _label = 'Alarm';
    }
    
    _labelController = TextEditingController(text: _label);
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: AppTheme.gradientBackground,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _buildTimePickerCard(),
              SizedBox(height: 20),
              _buildLabelInputCard(),
              SizedBox(height: 20),
              _buildToneSelectionCard(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(widget.existingAlarm != null ? 'Edit Alarm' : 'Set Alarm'),
      actions: [
        TextButton(
          onPressed: _saveAlarm,
          child: Text(
            'SAVE',
            style: TextStyle(
              color: AppTheme.primaryBlue,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePickerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        children: [
          Text(
            'Set Time',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: _selectTime,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                color: AppTheme.primaryBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _selectedTime.format(context),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabelInputCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Label',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _labelController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.secondaryCardBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              hintText: 'Enter alarm label',
              hintStyle: TextStyle(color: Colors.white54),
            ),
            onChanged: (value) {
              setState(() {
                _label = value.isEmpty ? 'Alarm' : value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildToneSelectionCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: AppTheme.cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alarm Tone',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 150,
            child: ListView.builder(
              itemCount: _availableTones.length,
              itemBuilder: (context, index) {
                final tone = _availableTones[index];
                return RadioListTile<String>(
                  title: Text(tone, style: TextStyle(color: Colors.white)),
                  value: tone,
                  groupValue: _selectedTone,
                  activeColor: AppTheme.primaryBlue,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedTone = value!;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: AppTheme.primaryBlue,
              surface: AppTheme.cardBackground,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _saveAlarm() {
    final alarm = Alarm(
      id: widget.existingAlarm?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      time: _selectedTime,
      tone: _selectedTone,
      label: _label,
      isEnabled: widget.existingAlarm?.isEnabled ?? true,
    );

    if (widget.existingAlarm != null) {
      AlarmService().updateAlarm(alarm);
    } else {
      AlarmService().addAlarm(alarm);
    }
    
    Navigator.pop(context);
  }
}