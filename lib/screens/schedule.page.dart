import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha Agenda',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
      ),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
            firstDay: DateTime(DateTime.now().year - 1),
            lastDay: DateTime(DateTime.now().year + 1),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
          ),
          // Adicione o restante do seu conteúdo aqui
        ],
      ),
    );
  }
}
