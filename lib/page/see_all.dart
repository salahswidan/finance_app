import 'package:finance_app/color/colors.dart';
import 'package:finance_app/cubit/fetch_data_cubit.dart';
import 'package:finance_app/model/finance_model.dart';
import 'package:finance_app/page/add.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime mySelectedDay = DateTime.now();
  DateTime myFoucedDay = DateTime.now();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchDataCubit>(context)
        .fetchDateData(dateTime: mySelectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Activities"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: BlocBuilder<FetchDataCubit, FetchDataState>(
          builder: (context, state) {
            return Column(
              children: [
                TableCalendar(
                  firstDay: DateTime(2024),
                  lastDay: DateTime.now(),
                  focusedDay: myFoucedDay,
                  calendarFormat: calendarFormat,
                  onFormatChanged: (format) {
                    setState(() {
                      calendarFormat = format;
                    });
                  },
                  currentDay: mySelectedDay,
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      mySelectedDay = selectedDay;
                      myFoucedDay = focusedDay;
                      BlocProvider.of<FetchDataCubit>(context).sel =
                          selectedDay;
                    });
                    BlocProvider.of<FetchDataCubit>(context)
                        .fetchDateData(dateTime: mySelectedDay);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: BlocProvider.of<FetchDataCubit>(context)
                            .todayFinanceList
                            .length,
                        itemBuilder: (context, index) {
                          List<FinanceModel> myList =
                              BlocProvider.of<FetchDataCubit>(context)
                                  .todayFinanceList;
                          return Padding(
                            padding: EdgeInsets.all(8),
                            child: Dismissible(
                              background: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Align(
                                    child: Icon(
                                      Icons.edit_calendar_outlined,
                                      color: KPrimaryGreen,
                                    ),
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                                decoration: BoxDecoration(color: KSeconderyRed),
                              ),
                              secondaryBackground: Container(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Align(
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: KPrimaryRed,
                                    ),
                                    alignment: Alignment.centerRight,
                                  ),
                                ),
                                decoration: BoxDecoration(color: KSeconderyRed),
                              ),
                              onDismissed: (direction) {
                                if (direction == DismissDirection.startToEnd) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddPage(
                                                IsPlus:
                                                    myList[index].financeValue <
                                                            0
                                                        ? false
                                                        : true,
                                                financeModel: myList[index],
                                              )));
                                } else if (direction ==
                                    DismissDirection.endToStart) {
                                  myList[index].delete();
                                  BlocProvider.of<FetchDataCubit>(context)
                                      .fetchData();
                                }
                              },
                              key: UniqueKey(),
                              child: Container(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          myList[index].financeValue > 0
                                              ? KSeconderyGreen
                                              : KSeconderyRed,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(myList[index].details.toString()),
                                        Text(DateFormat.yMMMEd()
                                            .format(myList[index].date)),
                                      ],
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        Text(myList[index].financeValue > 0
                                            ? "+"
                                            : ""),
                                        Text(myList[index]
                                            .financeValue
                                            .toString())
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }))
              ],
            );
          },
        ),
      ),
    );
  }
}
