class Hall
{
  String id;
  String name;
  String numbers;
  String air;
  String kind;
  String image;
  String cinemaname;
  String ticketprice;
  String status;

  Hall({this.id, this.name, this.numbers, this.air, this.image, this.cinemaname,this.status,this.kind , this.ticketprice});
  
  Hall.fromJson(Map<dynamic,dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else {
      id=map['id'];
      name=map['name'];
      numbers=map['numbers'];
      air=map['air'];
      image=map['image'];
      kind=map['kind'];
      cinemaname=map['cinemaname'];
      status=map['status'];
      ticketprice=map['tikcetprice'];
    }
  }
  toJson() {
    return {
      'id' : id,
      'name':name,
      'numbers':numbers,
      'air':air,
      'image':image,
      'cinemaname':cinemaname,
      'status':status,
      'kind':kind,
      'tikcetprice':ticketprice,
    };
  }
}