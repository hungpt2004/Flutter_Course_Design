class Comment {
  int postID;
  int? userID;
  String commentID;
  String content;

  Comment({required this.postID, required this.userID, required this.commentID, required this.content});

}

List<Comment> comments = [
  Comment(postID: 1, userID: 1, commentID: 'comment1', content: 'Great post!'),
  Comment(postID: 1, userID: 2, commentID: 'comment2', content: 'Interesting insights!'),
  Comment(postID: 2, userID: 3, commentID: 'comment3', content: 'Amazing content!'),
  Comment(postID: 3, userID: 4, commentID: 'comment4', content: 'I would love to visit the Alps someday!'),
  Comment(postID: 4, userID: 5, commentID: 'comment5', content: 'Italy is definitely on my bucket list!'),
  Comment(postID: 5, userID: 6, commentID: 'comment6', content: 'Nepal has the best hiking trails.'),
  Comment(postID: 6, userID: 7, commentID: 'comment7', content: 'The underwater life in Bali is so vibrant!'),
  Comment(postID: 7, userID: 8, commentID: 'comment8', content: 'Camping in the Amazon must be a thrilling experience!'),
  Comment(postID: 8, userID: 9, commentID: 'comment9', content: 'The Pyramids are on my travel list!'),
  Comment(postID: 8, userID: 10, commentID: 'comment10', content: 'Snowboarding in Canada sounds so exciting!'),
  Comment(postID: 3, userID: 11, commentID: 'comment11', content: 'The cherry blossoms in Japan are stunning.'),
];

