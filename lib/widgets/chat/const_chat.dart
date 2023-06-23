class Message {
  Enum? status;
  String? body;

  Message({this.status, this.body});
}

enum status { incoming, outgoing }

class Profile {
  String? imgpath;
  String? name;

  Profile({this.imgpath, this.name});
}



List<Profile> profiles = [
  Profile(imgpath: 'assets/profile.jpg', name: "Dr Drake"),
  Profile(imgpath: 'assets/medical.png', name: "Dr Ronaldo"),
  // Profile(imgpath: 'assets/profile.jpg', name: "Jeff"),
  // Profile(imgpath: 'assets/profile.jpg', name: "kane"),
  // Profile(imgpath: 'assets/profile.jpg', name: "Mark"),
  // Profile(imgpath: 'assets/profile.jpg', name: "Messi"),
  // Profile(imgpath: 'assets/profile.jpg', name: "osimhen"),
  // Profile(imgpath: 'assets/profile.jpg', name: "Pep"),
  // Profile(imgpath: 'assets/profile.jpg', name: "Ramos"),
  //Profile(imgpath: '$basepath/musk.jpg', name: "Musk"),
  //Profile(imgpath: '$basepath/cindy.jpg', name: "Cindy"),
  //Profile(imgpath: '$basepath/mufti.jpg', name: "Mufti"),
];