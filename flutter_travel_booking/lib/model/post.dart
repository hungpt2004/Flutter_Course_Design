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

  Post({required this.userId,this.id, this.title, this.content, this.hashtag, this.createdAt, this.comments,this.images, this.viewAmount});

}


List<Post> postsList = [
  Post(
    userId: 2,
    id: 1,
    title: 'My Travel Experience 🏔️',
    content: '''
      I had an amazing time visiting the Alps last summer. The scenery was nothing short of breathtaking. From the towering snow-capped mountains to the serene alpine lakes, every moment felt like a postcard come to life. I hiked through winding trails that offered panoramic views of lush green valleys and majestic peaks. Each step I took brought me closer to nature, and the fresh mountain air rejuvenated my senses.

      I spent a few days in a quaint mountain village, where I had the chance to interact with locals who shared fascinating stories about the region's rich history and culture. The hospitality was overwhelming, and I was introduced to traditional alpine dishes, such as cheese fondue and hearty stews, which warmed me up after long hikes.

      One of the most memorable experiences was reaching the summit of a challenging trail. Standing at the top, I felt on top of the world, surrounded by the vastness of nature. The feeling of accomplishment was immense, and I couldn’t help but feel grateful for such an unforgettable experience.

      The Alps truly hold a special place in my heart, and I can't wait to return someday to explore even more of its hidden gems. Whether you're an avid hiker or someone who simply appreciates beautiful landscapes, the Alps are a destination that should be on your bucket list.
    ''',
    hashtag: '#travel #Alps #mountains #adventure',
    createdAt: DateTime.now().subtract(Duration(days: 2)),
    comments: comments.where((c) => c.postID == 'post1').toList(),
    images: postImages,
    viewAmount: 12000,
  ),
  Post(
    userId: 1,
    id: 2,
    title: 'Delicious Food in Italy 🍕',
    content: '''
      My trip to Italy was a culinary journey like no other. The moment I landed in Rome, I could smell the aroma of fresh basil, garlic, and simmering tomatoes wafting through the air. Italy is truly a paradise for food lovers, and every meal was an experience in itself. I was fortunate enough to enjoy authentic Italian pasta and pizza in various regions, each with its own unique twist.

      In Rome, I visited traditional trattorias, where I savored rich pasta dishes like carbonara and cacio e pepe. The pasta was always cooked to perfection, and the sauce, made with the freshest ingredients, was absolutely divine. The pizza in Italy was unlike anything I've ever had. Thin, crispy crusts topped with simple yet delicious ingredients like buffalo mozzarella, fresh tomatoes, and aromatic herbs.

      I also ventured to Naples, the birthplace of pizza, where I had the chance to taste a true Neapolitan pizza. The simplicity of the ingredients—just dough, mozzarella, tomato, and a drizzle of olive oil—made for the most flavorful pizza I've ever eaten. It was the epitome of perfection in simplicity.

      Beyond the food, Italy's culture and history added depth to the experience. While enjoying meals, I learned about the origins of these dishes and their importance in Italian culture. It’s safe to say that Italy’s food culture is an integral part of its charm, and I would recommend anyone with a love for food to experience it firsthand.
    ''',
    hashtag: '#food #Italy #Rome #pizza #pasta #travel',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
    comments: comments.where((c) => c.postID == 'post2').toList(),
    images: [postImages[1]],
    viewAmount: 24000,
  ),
  Post(
    userId: 3,
    id: 3,
    title: 'Hiking Adventure in Nepal 🥾',
    content: '''
      Nepal is a haven for hikers, and my recent adventure there was one I will never forget. From the moment I arrived in Kathmandu, I knew this trip would be extraordinary. The bustling streets, the ancient temples, and the majestic Himalayas looming in the distance set the stage for an unforgettable experience.

      I trekked through the Annapurna Circuit, one of the most famous hiking trails in Nepal. The trail took me through lush forests, charming villages, and over high-altitude passes. The views were absolutely stunning—snow-capped peaks, serene rivers, and terraced fields stretching as far as the eye could see.

      One of the highlights of the trek was crossing Thorong La Pass, the highest point of the circuit. At 5,416 meters (17,769 feet), the air was thin, and every step felt like a challenge, but the view from the top was more than worth it. I was surrounded by towering peaks that seemed to touch the sky, and I felt a sense of awe and accomplishment that I can hardly put into words.

      The people I met along the way made the journey even more special. The Nepalese are incredibly warm and hospitable, and their stories about the mountains and their way of life were fascinating. I also had the opportunity to experience the local cuisine, which was simple yet flavorful—dal bhat, momo, and yak cheese were some of my favorite dishes.

      Hiking in Nepal was more than just a physical challenge—it was a spiritual journey. The mountains have a certain serenity that calms the mind, and I felt connected to something greater than myself. If you're an avid hiker or simply someone looking for an adventure, Nepal should be on your list.
    ''',
    hashtag: '#hiking #Nepal #adventure #trekking #mountains',
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
    comments: comments.where((c) => c.postID == 'post3').toList(),
    images: [postImages[2], postImages[3]],
    viewAmount: 18000,
  ),
  Post(
    userId: 1,
    id: 4,
    title: 'Underwater Wonders in Bali 🐠',
    content: '''
      Bali is renowned for its beautiful beaches, but there is an entirely different world beneath the waves that is equally enchanting. I had the chance to go scuba diving off the coast of Bali, and it was an experience like no other. The underwater landscape was a vibrant kaleidoscope of coral reefs, schools of fish, and sea turtles gliding gracefully through the water.

      I dived at several spots around the island, including Tulamben, where the famous USS Liberty wreck is located. The wreck is covered in colorful coral and has become a thriving ecosystem for marine life. Swimming around the wreck, I felt like I had stepped into another world—one where time seemed to stand still.

      Another dive site that took my breath away was Nusa Penida, where I swam with the majestic manta rays. These gentle giants were absolutely mesmerizing as they glided through the water, and I felt incredibly fortunate to be in their presence. The visibility in the waters of Bali was exceptional, allowing me to fully appreciate the beauty of the underwater world.

      Beyond the diving, Bali’s marine life and coral reefs are vital to the health of the ocean, and it was humbling to witness the delicate balance of this ecosystem. I left Bali with a deep respect for the ocean and its wonders, and I can't wait to return for more underwater adventures.
    ''',
    hashtag: '#diving #Bali #underwater #ocean #travel',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    comments: comments.where((c) => c.postID == 'post4').toList(),
    images: [postImages[4]],
    viewAmount: 15000,
  ),
  Post(
    userId: 4,
    id: 5,
    title: 'Chùa Linh Ứng 🐠',
    content: '''
    Chùa Linh Ứng, nằm ở bán đảo Sơn Trà, Đà Nẵng, là một trong những ngôi chùa nổi tiếng nhất của Việt Nam. Với vị trí tuyệt đẹp trên đỉnh núi Sơn Trà, nơi đây không chỉ là địa điểm tâm linh mà còn là một điểm du lịch hấp dẫn, thu hút hàng nghìn du khách trong và ngoài nước. Chùa Linh Ứng nổi bật với bức tượng Phật Bà Quan Âm cao nhất Việt Nam, tượng trưng cho sự từ bi, nhân hậu và bảo vệ bình an cho tất cả chúng sinh.

    Lối vào chùa là một con đường uốn lượn, dẫn lối lên đỉnh núi Sơn Trà, từ đây du khách có thể chiêm ngưỡng toàn cảnh thành phố Đà Nẵng và biển Đông xanh ngắt. Không khí tại đây rất trong lành và thanh tịnh, giúp du khách cảm nhận được sự yên bình và tĩnh lặng giữa thiên nhiên hùng vĩ.

    Chùa Linh Ứng còn có một khuôn viên rộng lớn với những cây cổ thụ, hồ nước, và các công trình kiến trúc độc đáo, mang đậm nét văn hóa Phật giáo. Đặc biệt, khu vực quanh bức tượng Phật Bà Quan Âm được thiết kế rất trang nghiêm và thanh tịnh, nơi đây thu hút không chỉ những tín đồ Phật giáo mà còn là điểm đến cho những ai yêu thích vẻ đẹp của thiên nhiên và muốn tìm lại sự bình an trong tâm hồn.

    Một trong những điểm đáng chú ý khác là tượng Phật Bà Quan Âm được xây dựng với chiều cao lên đến 67 mét, tạo nên một hình ảnh rất ấn tượng và tôn kính. Dưới chân tượng, có một không gian rộng rãi để khách hành hương và du khách có thể dâng hương, cầu nguyện và tham quan. Ngoài ra, trong khuôn viên chùa còn có những bức tranh tường, những tượng Phật khác, và các công trình phụ trợ thể hiện sự trang nghiêm và tôn kính của Phật giáo.

    Chùa Linh Ứng không chỉ là nơi tôn thờ Phật, mà còn là biểu tượng của sự phát triển và sự bảo vệ của thành phố Đà Nẵng. Khi đến đây, du khách không chỉ được chiêm bái Phật, mà còn có thể tận hưởng những giây phút thư giãn và hòa mình vào không gian tĩnh lặng của thiên nhiên, để tìm lại sự thanh thản trong tâm hồn.

    Với tất cả những nét đặc sắc đó, Chùa Linh Ứng là một địa điểm không thể bỏ qua đối với những ai yêu thích du lịch tâm linh cũng như muốn khám phá vẻ đẹp của Đà Nẵng từ một góc nhìn khác.
  ''',
    hashtag: '#ChuaLinhUng #DaNang #PhatGiao #Travel #Vietnam #SơnTra',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    comments: comments.where((c) => c.postID == 'post4').toList(),
    images: [postImages[4]],
    viewAmount: 15000,
  ),
  Post(
    userId: 5,
    id: 6,
    title: '東京の魅力を探索する 🇯🇵',
    content: '''
    日本の首都、東京は、古代と現代が見事に融合した街です。賑やかな街並みにネオンライトが輝き、静かな寺院や公園が点在し、東京はあらゆる旅行者にユニークな体験を提供します。

    東京で訪れるべきランドマークの一つは、浅草にある有名な浅草寺です。活気に満ちた仲見世通りを歩きながら、様々な伝統的な店でお土産や美味しい屋台料理を見かけました。浅草寺自体は、伝統的な日本建築の見事な例であり、地元の人々が祈る姿を目の当たりにするのは感動的でした。

    もう一つの東京のハイライトは、原宿に近い緑豊かな森に囲まれた明治神宮です。明治天皇と昭憲皇太后に捧げられたこの神社は、街の喧騒から逃れる平穏な場所です。大きな鳥居や木々に囲まれた美しい散歩道が静かな雰囲気を作り出し、世界でも最も忙しい都市の一つにいることを忘れさせてくれます。

    東京はまた、最先端のテクノロジーとポップカルチャーでも有名です。秋葉原の訪問は、まさに異次元の体験でした。この地区は、電子機器やアニメの聖地であり、明るい看板や多層の電気店、アニメグッズであふれています。
  ''',
    hashtag: '#東京 #旅行 #文化 #日本 #アニメ #テクノロジー',
    createdAt: DateTime.now().subtract(const Duration(days: 7)),
    comments: comments.where((c) => c.postID == 'post6').toList(),
    images: [postImages[5]],
    viewAmount: 12000,
  )
];


