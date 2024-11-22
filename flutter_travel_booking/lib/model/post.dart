import 'package:flutter_travel_booking/model/post_image.dart';

import 'comment.dart';

class Post {
  int userId;
  int? id;
  String? title;
  String? content;
  String? hashtag;
  DateTime? createdAt;
  List<Comment>? comments;
  List<PostImage>? images;
  int? viewAmount;
  int likes; // Số lượt thích
  int shares; // Số lượt chia sẻ
  int favoritesCount; // Số lượng yêu thích
  bool isFavorite; // Đã được yêu thích bởi người dùng chưa
  int get commentCount => comments?.length ?? 0; // Tự động tính số bình luận

  Post({
    required this.userId,
    this.id,
    this.title,
    this.content,
    this.hashtag,
    this.createdAt,
    this.comments,
    this.images,
    this.viewAmount,
    this.likes = 0,
    this.shares = 0,
    this.favoritesCount = 0,
    this.isFavorite = false,
  });
}


List<Post> postsList = [
  Post(
    userId: 2,
    id: 1,
    title: 'My Travel Experience 🏔️',
    content: '''
      Last summer, I had the chance to visit the majestic Alps, and it was an experience of a lifetime. The crisp mountain air, the towering peaks, and the serene blue lakes all combined to create a magical atmosphere. 
      
      Each day, I would hike through lush green meadows, where wildflowers bloomed in every color imaginable. At night, the sky was so clear that I could see the Milky Way stretching across the heavens. 🌌

      One of the highlights of my trip was visiting a quaint little village nestled in the valley. The locals were incredibly welcoming, and I even got to try traditional cheese fondue, which was absolutely delicious. 🧀 

      The Alps taught me the value of slowing down and appreciating nature's beauty. If you ever get the chance, I highly recommend adding the Alps to your travel bucket list! ✈️🌍
    ''',
    hashtag: '#travel #Alps #mountains #adventure',
    createdAt: DateTime.now().subtract(Duration(days: 2)),
    comments: commentsList.where((c) => c.postID == 1).toList(),
    images: postImages,
    viewAmount: 12000,
    likes: 250,
    shares: 120,
    favoritesCount: 150,
    isFavorite: true,
  ),
  Post(
    userId: 1,
    id: 2,
    title: 'Ẩm thực tuyệt vời ở Ý 🍕',
    content: '''
      Chuyến đi Ý vừa qua là một hành trình ẩm thực không thể quên. Từ những chiếc pizza giòn rụm tại Naples, đến các món pasta đặc sắc ở Rome, tất cả đều khiến tôi phải kinh ngạc. 🍝

      Một ngày nọ, tôi ghé thăm một nhà hàng nhỏ bên bờ sông Florence. Chủ nhà hàng là một đầu bếp địa phương đã truyền cảm hứng qua từng món ăn. Ông kể về cách chọn nguyên liệu tươi và quy trình làm thủ công. 
      
      Món tiramisu tráng miệng cuối cùng khiến tôi ngây ngất, mỗi lớp bánh mềm mịn và hương vị cà phê quyện với cacao rất hoàn hảo. ☕✨
      
      Ý không chỉ là một đất nước xinh đẹp, mà còn là thiên đường ẩm thực đáng để bạn khám phá. Nếu có cơ hội, bạn nhất định phải ghé qua! ❤️🇮🇹
    ''',
    hashtag: '#food #Italy #Rome #pizza #pasta #travel',
    createdAt: DateTime.now().subtract(Duration(days: 5)),
    comments: commentsList.where((c) => c.postID == 2).toList(),
    images: [postImages[1],postImages[2],postImages[3]],
    viewAmount: 24000,
    likes: 340,
    shares: 210,
    favoritesCount: 220,
    isFavorite: false,
  ),
  Post(
    userId: 3,
    id: 3,
    title: 'ネパールの冒険 🥾',
    content: '''
      ネパールの山々をハイキングするのは、一生に一度の素晴らしい経験でした。エベレストの麓に立ち、周囲の雄大な自然に圧倒されました。🏔️ 

      途中で、地元の村に立ち寄り、伝統的な料理であるダルバートを楽しみました。その香り豊かなカレーとライスは、疲れた体を癒してくれる最高のエネルギー補給でした。 🍛

      トレッキング中に見た朝焼けは、言葉では言い表せないほど美しく、感動的でした。それは自然が見せてくれる最高の芸術です。 🌄

      ネパールは冒険好きな人にとって理想的な場所です。自然の力を感じ、心身ともにリフレッシュできる素晴らしい旅でした。🎒🌏
    ''',
    hashtag: '#hiking #Nepal #adventure #trekking #mountains',
    createdAt: DateTime.now().subtract(Duration(days: 10)),
    comments: commentsList.where((c) => c.postID == 3).toList(),
    images: [postImages[3],postImages[4],postImages[7]],
    viewAmount: 15000,
    likes: 200,
    shares: 90,
    favoritesCount: 180,
    isFavorite: true,
  ),
  Post(
    userId: 4,
    id: 4,
    title: 'Exploring the Streets of Tokyo 🇯🇵',
    content: '''
      Tokyo is a vibrant city where tradition and modernity blend seamlessly. From the serene temples of Asakusa to the neon lights of Shibuya, there is always something to explore. 🚶‍♂️

      My favorite moment was strolling through the Tsukiji Fish Market and sampling fresh sushi. The quality of seafood here is unlike anywhere else in the world. 🍣

      Tokyo's energy is contagious, and it's a city that never sleeps. Whether you're enjoying a quiet tea ceremony or admiring the cherry blossoms in full bloom, Tokyo has something special for everyone. 🌸
    ''',
    hashtag: '#Tokyo #Japan #travel #sushi #citylife',
    createdAt: DateTime.now().subtract(Duration(days: 12)),
    comments: commentsList.where((c) => c.postID == 4).toList(),
    images: [postImages[5],postImages[6],postImages[3],postImages[4]],
    viewAmount: 8000,
    likes: 150,
    shares: 60,
    favoritesCount: 80,
    isFavorite: false,
  ),
  Post(
    userId: 5,
    id: 5,
    title: 'Safari in Kenya 🦁',
    content: '''
      Last year, I had the opportunity to go on a safari in Kenya, and it was an unforgettable experience. I had the chance to see the "Big Five" in their natural habitat: lions, elephants, leopards, buffalo, and rhinos. 🐘🐆

      The thrill of watching a lioness hunt was something I'll never forget. The vast savannas, the golden sunsets, and the sounds of nature were incredibly peaceful yet exhilarating at the same time. 🌅

      Kenya is truly a wild adventure waiting to be explored. If you're an animal lover, this is a must-visit destination. 🦓
    ''',
    hashtag: '#Kenya #safari #wildlife #adventure #Africa',
    createdAt: DateTime.now().subtract(Duration(days: 7)),
    comments: commentsList.where((c) => c.postID == 5).toList(),
    images: [postImages[6],postImages[11],postImages[9]],
    viewAmount: 5000,
    likes: 120,
    shares: 40,
    favoritesCount: 60,
    isFavorite: true,
  ),
  Post(
    userId: 6,
    id: 6,
    title: 'Paris: A City of Romance 💖',
    content: '''
      Paris, the city of love, stole my heart. From the iconic Eiffel Tower to the charming streets of Montmartre, there is no shortage of beauty around every corner. 🗼

      I spent hours wandering through art museums, sipping coffee at quaint cafés, and watching the world go by. The food here is absolutely divine, and I highly recommend trying the croissants and escargot. 🥐🦗

      Paris is more than just a city; it's a feeling. Every time I visit, I discover something new that makes me fall deeper in love with it. 🌹
    ''',
    hashtag: '#Paris #romance #travel #cityoflove #France',
    createdAt: DateTime.now().subtract(Duration(days: 14)),
    comments: commentsList.where((c) => c.postID == 6).toList(),
    images: [postImages[7],postImages[8],postImages[13]],
    viewAmount: 11000,
    likes: 280,
    shares: 130,
    favoritesCount: 190,
    isFavorite: false,
  ),
  Post(
    userId: 7,
    id: 7,
    title: 'Bali: Paradise on Earth 🌴',
    content: '''
      Bali is one of the most beautiful places I’ve ever visited. The island's serene beaches, lush jungles, and spiritual temples make it a paradise for nature lovers and adventurers alike. 🌺

      I had the chance to visit Ubud, known for its art and culture. The rice terraces there were breathtaking, and the locals' kindness made the experience even more memorable. 🥥

      Whether you're looking to relax on the beach or hike up Mount Batur for a stunning sunrise, Bali offers something for everyone. 🌅
    ''',
    hashtag: '#Bali #paradise #Indonesia #travel #beaches',
    createdAt: DateTime.now().subtract(Duration(days: 16)),
    comments: commentsList.where((c) => c.postID == 7).toList(),
    images: [postImages[8]],
    viewAmount: 14000,
    likes: 310,
    shares: 150,
    favoritesCount: 250,
    isFavorite: true,
  ),
  Post(
    userId: 8,
    id: 8,
    title: 'Discovering the Great Wall of China 🏯',
    content: '''
      Visiting the Great Wall of China was one of the most awe-inspiring experiences of my life. The wall stretches for miles, and standing atop it, surrounded by the stunning mountains, left me speechless. 🏔️

      The history of the Great Wall is as vast as the wall itself, and each section tells a different story. I spent hours walking along the path, learning about its significance and admiring the craftsmanship of the ancient builders. 🏰

      If you're a history buff or simply someone who loves breathtaking landscapes, the Great Wall is a must-see destination. 🧭
    ''',
    hashtag: '#China #GreatWall #history #travel #landmarks',
    createdAt: DateTime.now().subtract(Duration(days: 20)),
    comments: commentsList.where((c) => c.postID == 8).toList(),
    images: [postImages[9]],
    viewAmount: 16000,
    likes: 400,
    shares: 180,
    favoritesCount: 210,
    isFavorite: false,
  ),
  Post(
    userId: 9,
    id: 9,
    title: 'A Relaxing Escape in the Maldives 🏝️',
    content: '''
      The Maldives is the perfect place for a relaxing getaway. Picture-perfect beaches with clear turquoise waters, luxurious resorts, and plenty of opportunities to snorkel and scuba dive. 🐠

      I spent my days lounging by the beach, reading books, and enjoying freshly prepared seafood. The underwater life was a true highlight – I even swam with a school of colorful fish! 🐟

      If you're looking for peace and tranquility, the Maldives is the ultimate destination. 🏖️
    ''',
    hashtag: '#Maldives #beach #vacation #travel #luxury',
    createdAt: DateTime.now().subtract(Duration(days: 25)),
    comments: commentsList.where((c) => c.postID == 9).toList(),
    images: [postImages[10]],
    viewAmount: 13000,
    likes: 330,
    shares: 140,
    favoritesCount: 170,
    isFavorite: true,
  ),
  Post(
    userId: 10,
    id: 10,
    title: 'Trekking Through Patagonia 🏞️',
    content: '''
      Patagonia is a trekkers' paradise, with its vast glaciers, rugged mountains, and sprawling national parks. I had the chance to hike through Torres del Paine, and the views were nothing short of spectacular. 🌄

      The terrain was challenging, but the reward was worth it. From standing in front of massive glaciers to watching condors soar above the peaks, every moment felt like a scene from a nature documentary. 🦅

      Patagonia's untouched beauty is a reminder of the power and splendor of nature. It's a must-visit for anyone who loves the outdoors. 🏕️
    ''',
    hashtag: '#Patagonia #trekking #nature #travel #mountains',
    createdAt: DateTime.now().subtract(Duration(days: 30)),
    comments: commentsList.where((c) => c.postID == 10).toList(),
    images: [postImages[11],],
    viewAmount: 9000,
    likes: 210,
    shares: 100,
    favoritesCount: 120,
    isFavorite: false,
  ),
  Post(
    userId: 11,
    id: 11,
    title: 'Sunsets in Santorini 🌅',
    content: '''
      Santorini, with its whitewashed buildings and blue-domed churches, is one of the most picturesque places I've ever visited. The sunsets here are truly magical, and I couldn't help but be in awe as the sun dipped below the horizon. 🌞

      I spent my time exploring the charming streets, enjoying local delicacies, and watching the world-famous sunsets that draw tourists from all over the globe. 🍷

      Santorini is a place that will steal your heart, and I highly recommend visiting if you're ever in Greece. 🇬🇷
    ''',
    hashtag: '#Santorini #Greece #sunset #travel #islands',
    createdAt: DateTime.now().subtract(Duration(days: 35)),
    comments: commentsList.where((c) => c.postID == 11).toList(),
    images: [postImages[12],postImages[10]],
    viewAmount: 15000,
    likes: 370,
    shares: 200,
    favoritesCount: 230,
    isFavorite: true,
  ),
  Post(
    userId: 12,
    id: 12,
    title: 'Exploring New Zealand’s Natural Wonders 🏞️',
    content: '''
      New Zealand is a country of incredible natural beauty, from its rolling hills to its stunning fjords. I had the chance to visit Milford Sound, and it was one of the most awe-inspiring places I’ve ever been. 🏞️

      The crystal-clear waters, towering cliffs, and lush greenery made it feel like I was stepping into a movie set. I also explored the geothermal wonders of Rotorua and hiked through Tongariro National Park. 🌋

      If you're looking for outdoor adventure, New Zealand should be at the top of your list. 🌍
    ''',
    hashtag: '#NewZealand #adventure #travel #nature #fjords',
    createdAt: DateTime.now().subtract(Duration(days: 40)),
    comments: commentsList.where((c) => c.postID == 12).toList(),
    images: [postImages[13]],
    viewAmount: 17000,
    likes: 440,
    shares: 220,
    favoritesCount: 270,
    isFavorite: false,
  ),
];




