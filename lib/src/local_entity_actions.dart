class CreateOne<T> {
  const CreateOne(this.entity);
  final T entity;
  Map<String, dynamic> toJson() => {
        'entity': entity,
      };
}

class UpdateOne<T> {
  const UpdateOne(this.entity);
  final T entity;
  Map<String, dynamic> toJson() => {
        'entity': entity,
      };
}

class DeleteOne<T> {
  const DeleteOne(this.id);
  final String id;
  Map<String, dynamic> toJson() => {
        'id': id,
      };
}
