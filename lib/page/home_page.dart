import 'package:finance_app/color/colors.dart';
import 'package:finance_app/cubit/fetch_data_cubit.dart';
import 'package:finance_app/model/finance_model.dart';
import 'package:finance_app/page/add.dart';
import 'package:finance_app/page/see_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<FetchDataCubit>(context).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box("darkModeBox").listenable(),
      builder: (context, box, child) {
        var darkMode = box.get("darkMode", defaultValue: false);
        return Scaffold(
          appBar: AppBar(
            title: Text("Welcome , Salah"),
            actions: [
              IconButton(
                  onPressed: () {
                    box.put('darkMode', !darkMode);
                  },
                  icon: Icon(Icons.brightness_5_rounded))
            ],
          ),
          drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DrawerHeader(
                      child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        child: Text("S"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Salah Swidan"),
                    ],
                  )),
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          title: Text("Dark Mode"),
                          trailing: Switch(
                              value: darkMode,
                              onChanged: (value) {
                                box.put("darkMode", !darkMode);
                              }),
                        ),
                        Divider(),
                        ListTile(
                          title: Text("All Activities"),
                          trailing: Icon(Icons.local_atm_rounded),
                          onTap: () {
                            Navigator.pop(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeeAll(),
                              ),
                            );
                          },
                        ),
                        ListTile(
                          title: Text("Close Drawer"),
                          trailing: Icon(Icons.close),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text("Exit App"),
                    trailing: Icon(Icons.exit_to_app),
                    onTap: () {
                      SystemNavigator.pop();
                    },
                  ),
                ],
              ),
            ),
          ),
          body: BlocBuilder<FetchDataCubit, FetchDataState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: state is FetchDataLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: 120,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12)),
                                      color: KBlackColor,
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'My Balance',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            NumberFormat.compactCurrency(
                                                    decimalDigits: 2,
                                                    symbol: "")
                                                .format(BlocProvider.of<
                                                        FetchDataCubit>(context)
                                                    .sum)
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 32),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: KSeconderyPurble,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12))),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 120,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12)),
                                      color: KBlackColor,
                                    ),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 20.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            'Today Balance',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          Text(
                                            BlocProvider.of<FetchDataCubit>(
                                                    context)
                                                .todaySum
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 32),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 70,
                                  decoration: BoxDecoration(
                                      color: KSeconderyBlue,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(12))),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddPage(
                                                IsPlus: true,
                                              ))),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: KSeconderyGreen,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: KPrimaryGreen,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Plus",
                                          style:
                                              TextStyle(color: KPrimaryGreen),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddPage(
                                                IsPlus: false,
                                              ))),
                                  child: Container(
                                    padding: EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: KSeconderyRed,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.remove,
                                          color: KPrimaryRed,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Minus",
                                          style: TextStyle(color: KPrimaryRed),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Text("Activity"),
                              Spacer(),
                              GestureDetector(
                                child: Text("See All"),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SeeAll()));
                                },
                              ),
                            ],
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount:
                                      BlocProvider.of<FetchDataCubit>(context)
                                          .todayFinanceList
                                          .length,
                                  itemBuilder: (context, index) {
                                    List<FinanceModel> myList =
                                        BlocProvider.of<FetchDataCubit>(context)
                                            .todayFinanceList
                                            .reversed
                                            .toList();
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
                                          decoration: BoxDecoration(
                                              color: KSeconderyRed),
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
                                          decoration: BoxDecoration(
                                              color: KSeconderyRed),
                                        ),
                                        onDismissed: (direction) {
                                          if (direction ==
                                              DismissDirection.startToEnd) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AddPage(
                                                          IsPlus: myList[index]
                                                                      .financeValue <
                                                                  0
                                                              ? false
                                                              : true,
                                                          financeModel:
                                                              myList[index],
                                                        )));
                                          } else if (direction ==
                                              DismissDirection.endToStart) {
                                            myList[index].delete();
                                            BlocProvider.of<FetchDataCubit>(
                                                    context)
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
                                                    myList[index].financeValue >
                                                            0
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
                                                  Text(myList[index]
                                                      .details
                                                      .toString()),
                                                  Text(DateFormat.yMMMEd()
                                                      .format(
                                                          myList[index].date)),
                                                ],
                                              ),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  Text(myList[index]
                                                              .financeValue >
                                                          0
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
                      ),
              );
            },
          ),
        );
      },
    );
  }
}
