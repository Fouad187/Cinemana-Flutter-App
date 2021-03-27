class UserModel
{
  String id;
  String name;
  String email;
  String type;
  String city;

  UserModel({this.id,this.name, this.email, this.type,this.city});

  UserModel.fromJson(Map<dynamic,dynamic> map){
    if(map==null)
    {
      return;
    }
    id=map['id'];
    name=map['name'];
    email=map['email'];
    type=map['type'];
    city=map['city'];
  }
  toJson()
  {
    return {
      'id' : id,
      'name' : name,
      'email' :email,
      'type' : type,
      'city':city,
    };
  }
}