class Pet {
  String? name;
  int? age;
  String? color;
  int? category;
  String? image;
  bool? isRented;

  Pet(
      {this.name,
      this.age,
      this.color,
      this.category,
      this.image,
      this.isRented});

  Pet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    color = json['color'];
    category = json['category'];
    image = json['image'];
    isRented = json['is_rented'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['age'] = this.age;
    data['color'] = this.color;
    data['category'] = this.category;
    data['image'] = this.image;
    data['is_rented'] = this.isRented;
    return data;
  }
}
