class userDto {
  int id;
  String username;
  String role;

  userDto(this.id, this.username, this.role);

  factory userDto.fromJson(Map<String, dynamic> json) {
    return userDto(json['id'], json['username'], json['role']);
  }
}