// ignore_for_file: public_member_api_docs, sort_constructors_first
class ObjectId {
  final int id;
  final String value;

  const ObjectId(this.id, this.value);

  @override
  String toString() => '\nObjectId(id: $id, value: $value)';
}
