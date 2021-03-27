import 'package:cinema/Models/film_model.dart';
import 'package:cinema/Services/user_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminServices
{

  deleteCinema(String docid) async
  {
    try {
      await FirebaseFirestore.instance.collection('Cinema').doc(docid).delete().then((value) async {

        await deleteFilms(docid);
        await deleteHalls(docid);
        await deleteSnacks(docid);
      });
    }
    catch(e)
    {
      
    }
  }

  void deleteFilms(String id) async
  {
    await FirebaseFirestore.instance.collection('Films').where('id' , isEqualTo: id).get().then((value) async{

      for(int i=0 ; i<value.docs.length; i++)
        {
         await FirebaseFirestore.instance.collection('Films').doc(value.docs[i].id).delete();
        }
    });
  }
  
  void deleteHalls(String id) async
  {
    await FirebaseFirestore.instance.collection('Halls').where('id' , isEqualTo: id).get().then((value) async{

      for(int i=0 ; i<value.docs.length; i++)
      {
        await FirebaseFirestore.instance.collection('Halls').doc(value.docs[i].id).delete();
      }
    });
  }
  
  void deleteSnacks(String id) async 
  {
    await FirebaseFirestore.instance.collection('Snacks').where('id' , isEqualTo: id).get().then((value) async{

      for(int i=0 ; i<value.docs.length; i++)
      {
        await FirebaseFirestore.instance.collection('Snacks').doc(value.docs[i].id).delete();
      }
    });
  }
}