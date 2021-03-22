class BookModel {
  const BookModel({this.id, this.title});
  final String? id;
  final String? title;

  String toString() {
    return '$id : $title';
  }
}

const AClockworkOrange = const BookModel(
  id: 'aco',
  title: 'A Clockwork Orange',
);
const AnimalFarm = const BookModel(
  id: 'af',
  title: 'Animal Farm',
);

const TheGreatGatsby = const BookModel(
  id: 'tgg',
  title: 'The Great Gatsby',
);
