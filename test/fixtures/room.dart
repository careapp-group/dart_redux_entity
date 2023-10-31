class RoomModel {
  const RoomModel({this.id, this.name});
  final int? id;
  final String? name;

  String toString() {
    return '$id : $name';
  }
}

const Room404 = const RoomModel(id: 404, name: 'Not Found');

const Room255 = const RoomModel(id: 0xff, name: 'Room 255');

const RoomMax = const RoomModel(id: 0x7fffffff, name: 'Max');
