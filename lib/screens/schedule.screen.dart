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
        automaticallyImplyLeading: false,
        title: const Text(
          'Meus Eventos',
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
              titleCentered: true,
              formatButtonVisible: true,
              headerPadding: EdgeInsets.zero,
              formatButtonShowsNext: true,
              leftChevronIcon: Icon(
                Icons.chevron_left,
                size: 24,
                color: Colors.black54,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                size: 24,
                color: Colors.black54,
              ),
            ),
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
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
          Expanded(
            child: ListView(
              children: [
                Image.asset("assets/calendar.png"),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Não há eventos para esta data",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  style: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  "Clique no botão abaixo para adicionar eventos à sua agenda.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Adicionar evento",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
