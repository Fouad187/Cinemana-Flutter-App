class Snacks
{
  String id;
  String name;
  String price;
  String image;
  String cinemaname;
  String status;

  Snacks({this.id, this.name, this.price, this.image, this.cinemaname,this.status});

  Snacks.fromJson(Map<dynamic,dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else
      {
        id=map['id'];
        name=map['name'];
        price=map['price'];
        image=map['image'];
        cinemaname=map['cinemaname'];
        status=map['status'];
      }
  }
  toJson()
  {
    return {
      'id' : id,
      'name':name,
      'price':price,
      'image':image,
      'cinemaname':cinemaname,
      'status':status,
    };
  }
}