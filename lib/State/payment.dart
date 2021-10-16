import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentValues {
  double deposit;
  int months;
  bool delivery;

  PaymentValues({this.delivery, this.deposit, this.months});

  double get rent => deposit / 10;
  double get deliveryCharge => delivery ? 40 : 0;
  double get convenienceFee => 5 * (rent + deliveryCharge + deposit) / 100;
  double get total =>
      deposit + (rent * months) + deliveryCharge + convenienceFee;
}

class PaymentState extends StateNotifier<PaymentValues> {
  PaymentState() : super(null);

  void setValues(double deposit, int months, bool delivery) {
    if (deposit == null || months == null || delivery == null) {
      return;
    }
    state = PaymentValues(delivery: delivery, months: months, deposit: deposit);
  }

  void reset() {
    state = null;
  }
}

final paymentProvider =
    StateNotifierProvider<PaymentState, PaymentValues>((ref) => PaymentState());
