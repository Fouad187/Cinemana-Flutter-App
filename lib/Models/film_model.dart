class Film
{
  String id;
  String name;
  String category;
  String description;
  String rating;
  String image;
  String cinemaname;
  String status;

  Film({this.name, this.category, this.description, this.rating, this.image , this.id , this.cinemaname,this.status});

  Film.fromJson(Map<dynamic,dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else {
      name=map['name'];
      category=map['category'];
      description=map['description'];
      rating=map['rating'];
      image=map['image'];
      id=map['id'];
      cinemaname=map['cinemaname'];
      status=map['status'];
    }
  }
  toJson()
  {
    return {
      'name' : name,
      'category' : category,
      'description' : description,
      'rating' : rating,
      'image':image,
      'id':id,
      'cinemaname':cinemaname,
      'status':status,
    };
  }
}