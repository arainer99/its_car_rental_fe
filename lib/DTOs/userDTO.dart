class UserDTO {
  int id;
  String name;
  String surName;
  String mail;
  String role;

  UserDTO(this.id, this.mail, this.name, this.surName, this.role);

  UserDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mail = json['email'];
    name = json['firstName'];
    surName = json['lastName'];
    role = json['role'];
  }

  factory UserDTO.fromJsonFactory(Map<String, dynamic> json) {
    return UserDTO.fromJson(json);
  }
}