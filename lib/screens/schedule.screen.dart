import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../services/service.health.dart';
import '../services/health_event.model.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final HealthService _healthService = HealthService();
  List<HealthEvent> _allEvents = [];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<HealthEvent> _getEventsForDay(DateTime day) {
    return _allEvents.where((event) => isSameDay(event.dateTime, day)).toList();
  }

  IconData _getIconForType(HealthEventType type) {
    switch (type) {
      case HealthEventType.appointment:
        return Icons.medical_services;
      case HealthEventType.vaccination:
        return Icons.vaccines;
      case HealthEventType.medication:
        return Icons.medication;
      case HealthEventType.care:
        return Icons.pets;
      default:
        return Icons.event;
    }
  }

  Color _getColorForType(HealthEventType type) {
    switch (type) {
      case HealthEventType.appointment:
        return Colors.purple;
      case HealthEventType.vaccination:
        return Colors.red;
      case HealthEventType.medication:
        return Colors.orange;
      case HealthEventType.care:
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Meus Eventos',
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
      ),
      body: StreamBuilder<List<HealthEvent>>(
        stream: _healthService.getHealthEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          _allEvents = snapshot.data ?? [];
          final selectedEvents = _getEventsForDay(_selectedDay ?? _focusedDay);

          return Column(
            children: [
              TableCalendar(
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  headerPadding: EdgeInsets.zero,
                  leftChevronIcon:
                      Icon(Icons.chevron_left, color: Colors.purple),
                  rightChevronIcon:
                      Icon(Icons.chevron_right, color: Colors.purple),
                ),
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.purpleAccent,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                ),
                firstDay: DateTime(DateTime.now().year - 1),
                lastDay: DateTime(DateTime.now().year + 1),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                eventLoader: _getEventsForDay,
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
                    _focusedDay = focusedDay;
                  });
                },
              ),
              const Divider(),
              Expanded(
                child: selectedEvents.isEmpty
                    ? ListView(
                        children: [
                          const SizedBox(height: 40),
                          Image.asset("assets/calendar.png", height: 150),
                          const SizedBox(height: 16),
                          const Text(
                            "Não há eventos para esta data",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              "Adicione consultas, vacinas ou cuidados nas abas de saúde para vê-los aqui.",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: selectedEvents.length,
                        itemBuilder: (context, index) {
                          final event = selectedEvents[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: _getColorForType(event.type).withOpacity(0.1),
                                backgroundImage: event.petImageUrl != null 
                                  ? NetworkImage(event.petImageUrl!) 
                                  : null,
                                child: event.petImageUrl == null 
                                  ? Icon(_getIconForType(event.type), color: _getColorForType(event.type))
                                  : null,
                              ),
                              title: Text(
                                event.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(event.description),
                                  if (event.petName != null)
                                    Text(
                                      "Pet: ${event.petName}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.purple),
                                    ),
                                ],
                              ),
                              trailing: Text(
                                DateFormat('HH:mm').format(event.dateTime),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
