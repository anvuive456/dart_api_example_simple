class DepartmentModel {
  String _id ='';
  String? _name;

  String get id => this._id;

  String get name => this._name ?? 'unnamed';

  DepartmentModel(this._id, this._name);

  DepartmentModel.map(Map<String, dynamic> map){
    this._name = map['name'];
    this._id = map['id'];
  }

  Map<String, dynamic> toJson() =>
      {
        'id': this._id,
        'name': this._name,
      };
}
