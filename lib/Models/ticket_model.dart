class Ticket
{
  String id;
  String senderId;
  String filmName;
  String cinemaName;
  String cinemaAddress;
  String hallName;
  String filmTime;
  String position;
  String numberofSeats;
  String snacksName;
  String ticketdate;
  String numberofsnacks;
  String status;
  int total;
  DateTime date;

  Ticket({
    this.id,
    this.senderId,
    this.filmName,
    this.cinemaName,
    this.cinemaAddress,
    this.hallName,
    this.filmTime,
    this.position,
    this.numberofSeats,
    this.snacksName,
    this.numberofsnacks,
    this.status,
    this.date,
    this.ticketdate,
    this.total,
  });

  Ticket.fromJson(Map<dynamic,dynamic> map)
  {
    if(map==null)
      {
        return;
      }
    else
      {
        id=map['id'];
        senderId=map['senderid'];
        filmName=map['filmname'];
        cinemaName=map['cinemaname'];
        cinemaAddress=map['cinemaaddress'];
        hallName=map['hallname'];
        filmTime=map['filmtime'];
        position=map['position'];
        numberofSeats=map['numberofseats'];
        snacksName=map['snackname'];
        numberofsnacks=map['numberofsnacks'];
        status=map['status'];
        ticketdate=map['ticketdate'];
        total=map['total'];
      }
  }
  toJson()
  {
    return {
      'id' : id,
      'senderid':senderId,
      'filmname':filmName,
      'cinemaname':cinemaName,
      'cinemaaddress':cinemaAddress,
      'hallname':hallName,
      'filmtime':filmTime,
      'position':position,
      'numberofseats':numberofSeats,
      'snackname':snacksName,
      'numberofsnacks':numberofsnacks,
      'status':status,
      'date': date,
      'ticketdate':ticketdate,
      'total':total,
    };
  }
}