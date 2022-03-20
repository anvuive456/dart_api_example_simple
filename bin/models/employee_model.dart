class EmployeeModel {
  String _id = '';
  String? _name;

  String get id => this._id;

  String get name => this._name ?? 'unnamed';

  EmployeeModel(this._id, this._name);

  EmployeeModel.map(Map<String, dynamic> map) {
    this._name = map['name'];
    this._id = map['id'];
  }

  Map<String, dynamic> toJson() => {
        'id': this._id,
        'name': this._name,
      };
}
