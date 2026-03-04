import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/feture/home/cubit/home_state.dart';
import 'package:thimar/model/category_model.dart';
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
      try {
        sliders = List<SliderModel>.from(
            response.data['data'].map((x) => SliderModel.fromJson(x)));
        emit(HomeSliderSuccess(sliders));
      } catch (e) {
        emit(HomeSliderError("default_error".tr()));
      }
    } else {
      emit(HomeSliderError(response.message));
    }
  }

  List<CategoryModel> categories = [];

  Future<void> getCategories() async {
    emit(GetCategoriesLoading()); 

    final response = await serverGate.get(path: 'categories');

    if (isClosed) return;

    if (response.isSuccess) {
      try {
        categories = List<CategoryModel>.from(
            response.data['data'].map((x) => CategoryModel.fromJson(x)));
        emit(GetCategoriesSuccess(categories));
      } catch (e) {
        emit(GetCategoriesError("default_error".tr()));
      }
    } else {
      emit(GetCategoriesError(response.message));
    }
  }

  List<ProductModel> products = [];

  Future<void> getProducts() async {
    emit(GetProductsLoading());

    final response = await serverGate.get(path: 'products');

    if (isClosed) return;

    if (response.isSuccess) {
      try {
        products = List<ProductModel>.from(
            response.data['data'].map((x) => ProductModel.fromJson(x)));
        emit(GetProductsSuccess(products));
      } catch (e) {
        emit(GetProductsError("default_error".tr()));
      }
    } else {
      emit(GetProductsError(response.message));
    }
  }
}
