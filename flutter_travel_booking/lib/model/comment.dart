class Comment {
  int postID;
  int? userID;
  int commentID; // Thay đổi từ String thành int
  String content;
  int likes; // số lượng like
  DateTime createdAt; // thời gian tạo
  int replies; // số lượng phản hồi

  Comment({
    required this.postID,
    required this.userID,
    required this.commentID,
    required this.content,
    this.likes = 0, // mặc định 0 like
    DateTime? createdAt, // giá trị mặc định là thời gian hiện tại
    this.replies = 0, // mặc định không có phản hồi
  }) : createdAt = createdAt ?? DateTime.now();
}

// Cập nhật danh sách comments:
List<Comment> commentsList = [
  Comment(postID: 1, userID: 1, commentID: 1, content: 'Great post!', likes: 10, replies: 3),
  Comment(postID: 1, userID: 2, commentID: 2, content: 'Interesting insights!', likes: 5, replies: 1),
  Comment(postID: 2, userID: 3, commentID: 3, content: 'Amazing content!', likes: 8, replies: 2),
  Comment(postID: 3, userID: 4, commentID: 4, content: 'I would love to visit the Alps someday!', likes: 15, replies: 5),
  Comment(postID: 4, userID: 5, commentID: 5, content: 'Italy is definitely on my bucket list!', likes: 20, replies: 7),
  Comment(postID: 5, userID: 2, commentID: 6, content: 'Nepal has the best hiking trails.', likes: 12, replies: 4),
  Comment(postID: 1, userID: 5, commentID: 7, content: 'The underwater life in Bali is so vibrant!', likes: 9, replies: 2),
  Comment(postID: 2, userID: 1, commentID: 8, content: 'Camping in the Amazon must be a thrilling experience!', likes: 6, replies: 1),
  Comment(postID: 2, userID: 2, commentID: 9, content: 'The Pyramids are on my travel list!', likes: 4, replies: 0),
  Comment(postID: 4, userID: 3, commentID: 10, content: 'Snowboarding in Canada sounds so exciting!', likes: 14, replies: 3),
  Comment(postID: 3, userID: 1, commentID: 11, content: 'The cherry blossoms in Japan are stunning.', likes: 18, replies: 6),
];
