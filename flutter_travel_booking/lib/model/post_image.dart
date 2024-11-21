class PostImage {
  int? imageID;
  String? url;

  PostImage({this.imageID, this.url});
}

List<PostImage> postImages = [
  PostImage(imageID: 1, url: 'https://images.pexels.com/photos/16672664/pexels-photo-16672664/free-photo-of-a-sunrise-over-a-valley-with-fog-and-hills.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
  PostImage(imageID: 2, url: 'https://images.pexels.com/photos/258154/pexels-photo-258154.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
  // New images
  PostImage(imageID: 3, url: 'https://images.pexels.com/photos/460621/pexels-photo-460621.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
  PostImage(imageID: 4, url: 'https://images.pexels.com/photos/35600/road-sun-rays-path.jpg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
  PostImage(imageID: 5, url: 'https://images.pexels.com/photos/733174/pexels-photo-733174.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
  PostImage(imageID: 6, url: 'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
  PostImage(imageID: 7, url: 'https://images.pexels.com/photos/2387415/pexels-photo-2387415.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
];
