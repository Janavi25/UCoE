class ChatModel {
  String Email;
  String Name;
  String Photo;
  bool check;
  String uuid;
  String uiduser;
  String createRoom;
  String lastMessage;

  ChatModel(
      {this.Email,
      this.Name,
      this.check,
      this.uuid,
      this.Photo,
      this.uiduser,
      this.createRoom,
      this.lastMessage});

  factory ChatModel.fromDocument(doc) {
    return ChatModel(
        Email: doc['Email'],
        Name: doc['Name'],
        Photo: doc['Photo'],
        uuid: doc['uuid'],
        createRoom: doc['createRoom'],
        lastMessage: doc['lastMessage'],
        uiduser: doc['uiduser'],
        check: doc['check']);
  }
}



// String getRoomId(String uid,String fuid){
//   String a=uid;
//   String b=fuid;
//   if(a.codeUnitAt(0)==b.codeUnitAt(0)){
//      for(int i =0;i<=8;i++){
//         if(a.codeUnitAt(i)!=b.codeUnitAt(i)){
//              if(a.codeUnitAt(i)>b.codeUnitAt(i)){
//                 return a+b;
//                     }
//               else{
//                 return b+a;
//                  }
//         }
//      }
//   }
// //   else {
//     if(a.codeUnitAt(0)>b.codeUnitAt(0)){
//       return a+b;
//     }
//     else{
//       return b+a;
//     }
// //   }
  
// }

