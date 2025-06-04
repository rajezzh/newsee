// ignore_for_file: public_member_api_docs, sort_constructors_first
class DedupeRequest {
  String firstname;
  String lastname;
  String? panCard;
  String? mobileno;
  String aadharCard;
  DedupeRequest({required this.firstname, required this.lastname, this.mobileno, this.panCard, required this.aadharCard});
}