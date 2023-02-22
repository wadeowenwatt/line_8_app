import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/app_colors.dart';
import 'package:flutter_base/models/enums/load_status.dart';
import 'package:flutter_base/repositories/firestore_repository.dart';
import 'package:flutter_base/router/route_config.dart';
import 'package:flutter_base/ui/pages/calendar/calendar_cubit.dart';
import 'package:flutter_base/utils/app_date_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../blocs/app_cubit.dart';
import '../../../models/entities/event/event_entity.dart';

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  static var events = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay, hashCode: getHashCode);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        FirestoreRepository firestoreRepo =
            RepositoryProvider.of<FirestoreRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return CalendarCubit(firestoreRepo: firestoreRepo, appCubit: appCubit);
      },
      child: const _CalendarPage(),
    );
  }
}

class _CalendarPage extends StatefulWidget {
  const _CalendarPage({Key? key}) : super(key: key);

  @override
  State<_CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<_CalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late CalendarCubit _cubit;
  late AppCubit _appCubit;

  // Init state, set selected day = focused day = Datetime.now()
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _cubit = BlocProvider.of<CalendarCubit>(context);
    _appCubit = BlocProvider.of<AppCubit>(context);
    _cubit.getEvent();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            title: const Text("Calendar"),
            actions: [
              IconButton(
                onPressed: () {
                  Get.toNamed(RouteConfig.createEvent);
                },
                icon: const Icon(Icons.add),
              ),
            ],
            backgroundColor: AppColors.primaryDarkColorLeft,
          ),
          BlocBuilder<CalendarCubit, CalendarState>(
            builder: (context, state) {
              if (state.getEventStatus == LoadStatus.loading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Container(
                    color: AppColors.primaryDarkColorLeft,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          TableCalendar(
                            focusedDay: _focusedDay,
                            firstDay: AppDateUtils.kFirstDay,
                            lastDay: AppDateUtils.kLastDay,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            selectedDayPredicate: (day) =>
                                isSameDay(_selectedDay, day),
                            onDaySelected: _onDaySelected,

                            calendarFormat: _calendarFormat,

                            locale: "en_US",
                            // Set focused day again when page month change
                            onPageChanged: (focusedDay) {
                              _focusedDay = focusedDay;
                            },
                            eventLoader: _getEventsForDay,

                            // style calendar
                            calendarStyle: const CalendarStyle(
                              weekendDecoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.weekendColor,
                              ),
                              weekendTextStyle: TextStyle(color: Colors.black),
                              holidayTextStyle:
                                  TextStyle(color: AppColors.holidayColor),
                              defaultTextStyle: TextStyle(color: Colors.black),
                              markerDecoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Colors.red,
                              ),
                              markersMaxCount: 1,
                            ),
                            headerStyle: const HeaderStyle(
                              formatButtonVisible: false,
                              titleTextStyle: TextStyle(
                                color: Colors.black,
                              ),
                              titleCentered: true,
                            ),
                            calendarBuilders: CalendarBuilders(
                              markerBuilder: (context, day, events) {
                                if (events.isNotEmpty) {
                                  return Center(
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: day.weekday == DateTime.thursday
                                            ? Colors.red.withOpacity(0.3)
                                            : Colors.green.withOpacity(0.3),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ValueListenableBuilder<List<Event>>(
                            valueListenable: _selectedEvents,
                            builder: (context, value, _) {
                              return ListView.builder(
                                // add controller to make the listview scrollable in CustomScrollView
                                controller: ScrollController(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 15,
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            onTap: () => Get,
                                            title: Text(
                                              '${value[index].title} - ${value[index].timeStart?.toDate().toDateTimeString()}',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Use for get event
  List<Event> _getEventsForDay(DateTime day) {
    if (day.weekday == DateTime.thursday) {
      return [
        Event(
          id: 'cyclic_event',
          title: "Tech-Talk",
          timeStart: Timestamp.fromDate(day),
          timeStop: Timestamp.fromDate(day),
          details: "Tech-Talk hằng tuần",
          requested: true,
        ),
      ];
    }
    // _appCubit.addBirthday(day);
    return CalendarPage.events[day] ?? [];
  }

  void _onDaySelected(DateTime focusedDay, DateTime selectedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }
}
