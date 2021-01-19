class Consultation {
  final String name;
  final String referNumber;
  final String requestDate;
  final String status;
  final String question;
  bool isDone;

  Consultation({this.name, this.isDone = false,this.question,this.status
  ,this.referNumber,this.requestDate});

  void toggleDone() {
    isDone = !isDone;
  }
}
