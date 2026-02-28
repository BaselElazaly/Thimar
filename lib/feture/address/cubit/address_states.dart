
abstract class AddressStates {}

class AddressInitialState extends AddressStates {}

class GetAddressesLoadingState extends AddressStates {}

class GetAddressesSuccessState extends AddressStates {}

class GetAddressesErrorState extends AddressStates {
  final String message; 
  GetAddressesErrorState(this.message);
}

class DeleteAddressLoadingState extends AddressStates {}

class DeleteAddressSuccessState extends AddressStates {
  final String msg;
  DeleteAddressSuccessState(this.msg);
}

class DeleteAddressErrorState extends AddressStates {
  final String msg;
  DeleteAddressErrorState(this.msg);
}