class BaseDTO {
  int id;
  String createdAt;
  String updatedAt;

  BaseDTO(this.id, this.createdAt, this.updatedAt);

  BaseDTO.onlyId(this.id);
}