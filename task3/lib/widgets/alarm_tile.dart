import 'package:flutter/material.dart';
import '../models/alarm.dart';
import '../theme/app_theme.dart';

class AlarmTile extends StatelessWidget {
  final Alarm alarm;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback? onTap;

  const AlarmTile({
    Key? key,
    required this.alarm,
    required this.onToggle,
    required this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: AppTheme.cardDecoration(
        isEnabled: alarm.isEnabled,
        hasBorder: true,
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          alarm.isEnabled ? Icons.alarm : Icons.alarm_off,
          color: alarm.isEnabled ? AppTheme.primaryBlue : Colors.white30,
          size: 28,
        ),
        title: Text(
          alarm.time.format(context),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: alarm.isEnabled ? Colors.white : Colors.white30,
          ),
        ),
        subtitle: Text(
          '${alarm.label} • ${alarm.tone}',
          style: TextStyle(
            color: alarm.isEnabled ? Colors.white70 : Colors.white30,
            fontSize: 14,
          ),
        ),
        trailing: _buildTrailingActions(),
      ),
    );
  }

  Widget _buildTrailingActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Switch(
          value: alarm.isEnabled,
          onChanged: (_) => onToggle(),
          activeColor: AppTheme.primaryBlue,
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () => _showDeleteConfirmation(),
        ),
      ],
    );
  }

  void _showDeleteConfirmation() {
    // This would ideally be handled by a higher-level widget
    // For now, we'll call onDelete directly
    onDelete();
  }
}