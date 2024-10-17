import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:finance_app/model/finance_model.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'fetch_data_state.dart';

class FetchDataCubit extends Cubit<FetchDataState> {
  FetchDataCubit() : super(FetchDataInitial());
  List<FinanceModel> financeList = [];
  List<FinanceModel> todayFinanceList = [];
  double sum = 0;
  DateTime sel = DateTime.now();
  double todaySum = 0;

  fetchData() {
    emit(FetchDataLoading());
    try {
      financeList = Hive.box<FinanceModel>('financeBox').values.toList();
      fetchDateData();

      sum = 0;
      todaySum = 0;
      for (var element in financeList) {
        sum += element.financeValue;
      }
      for (var element in todayFinanceList) {
        todaySum += element.financeValue;
      }
      emit(FetchDataSuccess());
    } on Exception catch (e) {
      emit(FetchDataFailur(e.toString()));
    }
    return financeList;
  }

  fetchDateData({DateTime? dateTime}) {
    todayFinanceList = financeList
        .where((element) =>
            DateFormat.yMMMEd().format(element.date) ==
            DateFormat.yMMMEd().format(dateTime ?? DateTime.now()))
        .toList();
  }
}
