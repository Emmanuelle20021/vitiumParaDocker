import 'package:cloud_firestore/cloud_firestore.dart';

class Busqueda {
  FirebaseFirestore db = FirebaseFirestore.instance;

  buscar() async {
    await db.collectionGroup("vacantes").get().then(
          (QuerySnapshot querySnapshot) => {
            querySnapshot.docs.toList().forEach((element) {
              print(element.data());
            })
          },
        );
  }
}
