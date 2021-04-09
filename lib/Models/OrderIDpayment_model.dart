class OrderIDpayment_model{
  String id;
  String entity;
  int amount;
  int amountPaid;
  int amountDue;
  String currency;
  String receipt;
  String status;
  int attempts;

  OrderIDpayment_model({
      this.id,
      this.entity,
      this.amount,
      this.amountPaid,
      this.amountDue,
      this.currency,
      this.receipt,
      this.status,
      this.attempts,
      this.notes,
      this.createdAt});

  List<Null> notes;
  int createdAt;

}