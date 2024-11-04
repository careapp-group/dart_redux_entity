class UpdateBookModel {
  const UpdateBookModel({this.title});
  final String? title;

  String toString() {
    return 'Book update data: $title';
  }
}
