import 'package:flutter/material.dart';
import '../models/alarm.dart';
import '../theme/app_theme.dart';

class AlarmRingingDialog extends StatefulWidget {
  final Alarm alarm;
  final VoidCallback? onSnooze;
  final VoidCallback? onDismiss;

  const AlarmRingingDialog({
    Key? key,
    required this.alarm,
    this.onSnooze,
    this.onDismiss,
  }) : super(key: key);

  @override
  _AlarmRingingDialogState createState() => _AlarmRingingDialogState();
}

class _AlarmRingingDialogState extends State<AlarmRingingDialog>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAnimatedAlarmIcon(),
            SizedBox(height: 20),
            _buildAlarmTitle(),
            SizedBox(height: 8),
            _buildAlarmTime(),
            SizedBox(height: 8),
            _buildAlarmLabel(),
            SizedBox(height: 30),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedAlarmIcon() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Icon(
            Icons.alarm,
            size: 80,
            color: Colors.red,
          ),
        );
      },
    );
  }

  Widget _buildAlarmTitle() {
    return Text(
      'ALARM',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildAlarmTime() {
    return Text(
      widget.alarm.time.format(context),
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }

  Widget _buildAlarmLabel() {
    return Text(
      widget.alarm.label,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _handleSnooze,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'SNOOZE',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: _handleDismiss,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'DISMISS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _handleSnooze() {
    Navigator.of(context).pop();
    widget.onSnooze?.call();
  }

  void _handleDismiss() {
    Navigator.of(context).pop();
    widget.onDismiss?.call();
  }
}