import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/feture/home/cubit/home_state.dart';
import 'package:thimar/model/product_model.dart';
import 'package:thimar/model/slider_model.dart';

class HomeCubit extends Cubit<HomeState> {
  final ServerGate serverGate;

  HomeCubit(this.serverGate) : super(HomeInitial());

  List<SliderModel> sliders = [];

  Future<void> getSliders() async {
    emit(HomeSliderLoading());

    final response = await serverGate.get(path: 'sliders');

    if (isClosed) return;

    if (response.isSuccess) {
      sliders = List<SliderModel>.from(
          response.data['data'].map((x) => SliderModel.fromJson(x)));
      emit(HomeSliderSuccess(sliders));
    } else {
      emit(HomeSliderError(response.message));
    }
  }

  List<ProductModel> products = [];

  Future<void> getProducts() async {
    emit(GetProductsLoading());
    final response = await serverGate.get(path: 'products');

    if (isClosed) return;

    if (response.isSuccess) {
      products = List<ProductModel>.from(
          response.data['data'].map((x) => ProductModel.fromJson(x)));
      emit(GetProductsSuccess(products));
    } else {
      emit(GetProductsError(response.message));
    }
  }
}
