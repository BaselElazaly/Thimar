

import 'package:thimar/model/product_model.dart';
import 'package:thimar/model/slider_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeSliderLoading extends HomeState {}

class HomeSliderSuccess extends HomeState {
  final List<SliderModel> sliders;
  HomeSliderSuccess(this.sliders);
}

class HomeSliderError extends HomeState {
  final String message;
  HomeSliderError(this.message);
}

class GetProductsLoading extends HomeState {}

class GetProductsSuccess extends HomeState {
  final List<ProductModel> products;
  GetProductsSuccess(this.products);
}

class GetProductsError extends HomeState {
  final String message;
  GetProductsError(this.message);
}