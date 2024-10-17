import 'package:bloc/bloc.dart';
import 'package:finance_app/model/finance_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'add_data_state.dart';

class AddDataCubit extends Cubit<AddDataState> {
  AddDataCubit() : super(AddDataInitial());

  addData(FinanceModel financeModel) async {
    emit(AddDataLoading());
    try {
      await Hive.box<FinanceModel>('financeBox').add(financeModel);
      emit(AddDataSuccess());
    } on Exception catch (e) {
      emit(AddDataFailure());
    }
  }
}
