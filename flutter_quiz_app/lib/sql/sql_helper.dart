import 'package:flutter/cupertino.dart';
import 'package:flutter_quiz_app/model/completed_quiz.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/favorite.dart';
import '../model/pin.dart';
import '../model/question.dart';
import '../model/quiz.dart';
import '../model/rank.dart';
import '../model/subject.dart';
import '../model/user.dart';
import '../model/type.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  //Singleton Constructor
  DBHelper._init();

  //U S E R -- T A B L E
  final tableUser = '''
    CREATE TABLE USER (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       rank_id INTEGER NOT NULL,
       name TEXT,
       username TEXT,
       password TEXT,
       email TEXT,
       phone TEXT,
       dob TEXT,
       url TEXT,
       total_score INTEGER,
       FOREIGN KEY (rank_id) REFERENCES RANK(id)
    );
  ''';

  //C O M P L E T E D -- T A B L E
  final tableCompletedQuiz = '''
    CREATE TABLE COMPLETED_QUIZ (
      user_id INTEGER,
      quiz_id INTEGER,
      score INTEGER,
      completed_at TEXT,
      paid_at TEXT,
      PRIMARY KEY (user_id, quiz_id),
      FOREIGN KEY (user_id) REFERENCES USER (id),
      FOREIGN KEY (quiz_id) REFERENCES QUIZ (id)
    );
  ''';

  //R A N K -- T A B L E
  final tableRank = '''
    CREATE TABLE RANK (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      min_score INTEGER
    );
  ''';

  //D I S C O U N T -- T A B L E
  final tableDiscount = '''
    CREATE TABLE DISCOUNT (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      rank_id INTEGER,
      name TEXT,
      value INTEGER,
      FOREIGN KEY (rank_id) REFERENCES RANK(id)
    );
  ''';

  //Q U I Z -- T A B L E
  final tableQuiz = '''
    CREATE TABLE QUIZ (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      description TEXT,
      title TEXT,
      is_paid INTEGER NOT NULL CHECK (is_paid IN (0, 1)),
      price INTEGER,
      user_id INTEGER,
      subject_id INTEGER,
      type_id INTEGER,
      created_at TEXT,
      url TEXT,
      isFavorite INTEGER NOT NULL CHECK (is_paid IN (0, 1)),
      FOREIGN KEY (user_id) REFERENCES USER(id),
      FOREIGN KEY (subject_id) REFERENCES SUBJECT(id),
      FOREIGN KEY (type_id) REFERENCES TYPE(id)
    );
  ''';

  //Q U E S T I O N -- T A B L E
  final tableQuestion = '''
    CREATE TABLE QUESTION (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      image_url TEXT,
      content TEXT NOT NULL,
      answer1 TEXT NOT NULL,
      answer2 TEXT NOT NULL,
      answer3 TEXT NOT NULL,
      answer4 TEXT NOT NULL,
      correct_answer INTEGER NOT NULL,
      quiz_id INTEGER NOT NULL,
      FOREIGN KEY (quiz_id) REFERENCES QUIZ (id)
    );
  ''';

  //T Y P E -- T A B L E
  final tableType = '''
    CREATE TABLE TYPE (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT
    );
  ''';

  //S U B J E C T -- T A B L E
  final tableSubject = '''
    CREATE TABLE SUBJECT (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL
    );
  ''';

  //F E E D B A C K -- T A B L E
  final tableFeedback = '''
    CREATE TABLE FEEDBACK (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      content TEXT,
      created_at TEXT,
      user_id INTEGER,
      quiz_id INTEGER,
      FOREIGN KEY (user_id) REFERENCES USER (id),
      FOREIGN KEY (quiz_id) REFERENCES QUIZ (id)
    );
  ''';

  //P I N
  final tablePin = '''
      CREATE TABLE PIN (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pin TEXT,
        created_at TEXT,
        expired_at TEXT,
        user_id INTEGER,
        FOREIGN KEY (user_id) REFERENCES USER (id)
      );
  ''';

  //F A V O R I T E
  final tableFavorite = '''
      CREATE TABLE FAVORITE ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        quiz_id INTEGER,
        user_id INTEGER,
        created_at TEXT,
        FOREIGN KEY (user_id) REFERENCES USER (id),
        FOREIGN KEY (quiz_id) REFERENCES QUIZ (id)
      );
  ''';

  //Create name database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase('DatabaseBoi.db');
    return _database!;
  }

  //Get path database
  Future<Database> _initDatabase(String filePath) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filePath);
    return openDatabase(path, version: 1, onCreate: _onCreateDatabase);
  }

  //On create database
  Future<void> _onCreateDatabase(Database db, int version) async {
    try {
      await db.execute(tableUser);
      await db.execute(tableRank);
      await db.execute(tableDiscount);
      await db.execute(tableQuiz);
      await db.execute(tableCompletedQuiz);
      await db.execute(tableQuestion);
      await db.execute(tableType);
      await db.execute(tableSubject);
      await db.execute(tableFeedback);
      await db.execute(tablePin);
      await db.execute(tableFavorite);

      print("DA TAO BANG");

      //INSERT
      await insertRanks(db);
      await insertUsers(db);
      await insertDiscounts(db);
      await insertSubjects(db);
      await insertTypes(db);
      await insertQuizzes(db);
      await insertQuestions(db);

      print("DA INSERT");

    } catch (e) {
      debugPrint(e.toString());
    }
  }


  // ----------------------------------------------------- I N S E R T ------------------------------------------------------

  // I N S E R T -- R A N K
  Future<void> insertRanks(Database db) async {
    final ranks = [
      {'name': 'Bronze', 'min_score': 0},
      {'name': 'Silver', 'min_score': 800},
      {'name': 'Gold', 'min_score': 2000},
      {'name': 'Diamond', 'min_score': 3000},
      {'name': 'Master', 'min_score': 5000},
    ];
    for (final rank in ranks) {
      await db.insert('RANK', rank);
    }
  }

  // I N S E R T -- U S E R
  Future<void> insertUsers(Database db) async {
    final users = [
      {
        'rank_id': 1,
        'name': 'John Doe',
        'username': 'johnjohntest',
        'password': '123',
        'email': 'johndoe@example.com',
        'phone': '1234567890',
        'dob': '1995-01-01',
        'url':'https://randomuser.me/api/portraits/men/17.jpg',
        'total_score': 1200
      },
      {
        'rank_id': 2,
        'name': 'Jane Smith',
        'username': 'janequizpro',
        'password': '123',
        'email': 'janesmith@example.com',
        'phone': '0905256943',
        'dob': '1984-05-15',
        'url':'https://randomuser.me/api/portraits/men/35.jpg',
        'total_score': 1500
      },
      {
        'rank_id': 3,
        'name': 'Pham Trong Hung',
        'username': 'hungpt',
        'password': '123',
        'email': 'hungptfpt2004@gmail.com',
        'phone': '0987654321',
        'dob': '2004-02-20',
        'url':'https://randomuser.me/api/portraits/men/88.jpg',
        'total_score': 1500
      },
      {
        'rank_id': 4,
        'name': 'Kim Hoang Nguyen',
        'username': 'lkhnguyen',
        'password': '123',
        'email': 'haha@example.com',
        'phone': '0914259659',
        'dob': '2003-05-15',
        'url':'https://randomuser.me/api/portraits/men/51.jpg',
        'total_score': 1500
      },
      {
        'rank_id': 5,
        'name': 'Duyen Truong Thien',
        'username': 'duyenttt',
        'password': '123',
        'email': 'janesmith@example.com',
        'phone': '0914234252',
        'dob': '2002-05-15',
        'url':'https://randomuser.me/api/portraits/men/53.jpg',
        'total_score': 1500
      },
    ];
    for (final user in users) {
      await db.insert('USER', user);
    }
  }

  // I N S E R T -- Q U I Z
  Future<void> insertQuizzes(Database db) async {
    final quizzes = [
      // Quiz cho Java Programming
      {
        'title': 'Java Basics Quiz',
        'description': 'A quiz on basic Java programming concepts.',
        'is_paid': 0,  // 0 = miễn phí
        'price': 0,    // Giá 0 vì là quiz miễn phí
        'user_id': 1,  // Giả sử user_id = 1 tồn tại trong bảng USER
        'subject_id': 1,  // Giả sử subject_id = 1 là Java Programming trong bảng SUBJECT
        'type_id': 1,  // Giả sử type_id = 1 là Multiple Choice
        'created_at': DateTime.now().toIso8601String(),
        'url': 'https://simplycoding.in/wp-content/uploads/2021/06/Java-Theory-Java-Basics.jpg',
        'isFavorite':0
      },
      {
        'title': 'Advanced Java Quiz',
        'description': 'A quiz on advanced Java programming concepts.',
        'is_paid': 1,  // Quiz có phí
        'price': 500,  // Giá 500
        'user_id': 1,  // Giả sử user_id = 1 tồn tại trong bảng USER
        'subject_id': 1,  // Giả sử subject_id = 1 là Java Programming trong bảng SUBJECT
        'type_id': 1,  // Giả sử type_id = 1 là Multiple Choice
        'created_at': DateTime.now().toIso8601String(),
        'url': 'https://techshark.co.in/wp-content/uploads/2020/06/591-5916423_advanced-java-logo-png-transparent-png.png',
        'isFavorite':0
      },

      // Quiz cho Flutter Programming
      {
        'title': 'Flutter Basics Quiz',
        'description': 'A quiz on basic Flutter programming concepts.',
        'is_paid': 0,  // 0 = miễn phí
        'price': 0,    // Giá 0 vì là quiz miễn phí
        'user_id': 2,  // Giả sử user_id = 2 tồn tại trong bảng USER
        'subject_id': 2,  // Giả sử subject_id = 2 là Flutter Programming trong bảng SUBJECT
        'type_id': 1,  // Giả sử type_id = 1 là Multiple Choice
        'created_at': DateTime.now().toIso8601String(),
        'url': 'https://i.ytimg.com/vi/6JSZYIyPzfw/maxresdefault.jpg',
        'isFavorite':0
      },
      {
        'title': 'Advanced Flutter Quiz',
        'description': 'A quiz on advanced Flutter programming concepts.',
        'is_paid': 1,  // Quiz có phí
        'price': 1000, // Giá 1000
        'user_id': 2,  // Giả sử user_id = 2 tồn tại trong bảng USER
        'subject_id': 2,  // Giả sử subject_id = 2 là Flutter Programming trong bảng SUBJECT
        'type_id': 1,  // Giả sử type_id = 1 là Multiple Choice
        'created_at': DateTime.now().toIso8601String(),
        'url':'https://smazee.com/uploads/blog/How-to-Develop-Advanced-UI-in-Flutter.png',
        'isFavorite':0
      },

      // Quiz cho Android Programming
      // {
      //   'title': 'Android Basics Quiz',
      //   'description': 'A quiz on basic Android programming concepts.',
      //   'is_paid': 0,  // 0 = miễn phí
      //   'price': 0,    // Giá 0 vì là quiz miễn phí
      //   'user_id': 1,  // Giả sử user_id = 1 tồn tại trong bảng USER
      //   'subject_id': 3,  // Giả sử subject_id = 3 là Android Programming trong bảng SUBJECT
      //   'type_id': 1,  // Giả sử type_id = 1 là Multiple Choice
      //   'created_at': DateTime.now().toIso8601String(),
      // },
      // {
      //   'title': 'Advanced Android Quiz',
      //   'description': 'A quiz on advanced Android programming concepts.',
      //   'is_paid': 1,  // Quiz có phí
      //   'price': 800,  // Giá 800
      //   'user_id': 1,  // Giả sử user_id = 1 tồn tại trong bảng USER
      //   'subject_id': 3,  // Giả sử subject_id = 3 là Android Programming trong bảng SUBJECT
      //   'type_id': 1,  // Giả sử type_id = 1 là Multiple Choice
      //   'created_at': DateTime.now().toIso8601String(),
      // },
      //
      // // Quiz cho IOS Programming
      // {
      //   'title': 'iOS Basics Quiz',
      //   'description': 'A quiz on basic iOS programming concepts.',
      //   'is_paid': 0,  // 0 = miễn phí
      //   'price': 0,    // Giá 0 vì là quiz miễn phí
      //   'user_id': 2,  // Giả sử user_id = 2 tồn tại trong bảng USER
      //   'subject_id': 4,  // Giả sử subject_id = 4 là iOS Programming trong bảng SUBJECT
      //   'type_id': 1,  // Giả sử type_id = 1 là Multiple Choice
      //   'created_at': DateTime.now().toIso8601String(),
      // },
      // {
      //   'title': 'Advanced iOS Quiz',
      //   'description': 'A quiz on advanced iOS programming concepts.',
      //   'is_paid': 1,  // Quiz có phí
      //   'price': 1200, // Giá 1200
      //   'user_id': 2,  // Giả sử user_id = 2 tồn tại trong bảng USER
      //   'subject_id': 4,  // Giả sử subject_id = 4 là iOS Programming trong bảng SUBJECT
      //   'type_id': 1,  // Giả sử type_id = 1 là Multiple Choice
      //   'created_at': DateTime.now().toIso8601String(),
      // },

      // Quiz cho Ielts

      {
        'title': 'IELTS Speaking Quiz',
        'description': 'A quiz on IELTS Speaking skills.',
        'is_paid': 0,  // 0 = miễn phí
        'price': 0,    // Giá 0 vì là quiz miễn phí
        'user_id': 3,  // Giả sử user_id = 1 tồn tại trong bảng USER
        'subject_id': 8,  // Giả sử subject_id = 8 là IELTS trong bảng SUBJECT
        'type_id': 1,  // Giả sử type_id = 2 là True/False
        'created_at': DateTime.now().toIso8601String(),
        'url': 'https://smiletutor.sg/wp-content/uploads/2017/06/IELTS.png',
        'isFavorite':0
      },
      {
        'title': 'IELTS Listening Quiz',
        'description': 'A quiz on IELTS Listening skills.',
        'is_paid': 1,  // Quiz có phí
        'price': 1500, // Giá 1500
        'user_id': 3,  // Giả sử user_id = 1 tồn tại trong bảng USER
        'subject_id': 8,  // Giả sử subject_id = 8 là IELTS trong bảng SUBJECT
        'type_id': 1,
        'created_at': DateTime.now().toIso8601String(),
        'url':'https://th.bing.com/th/id/R.d7d7c6badeb9be43fdd45e326f69e76b?rik=PqiifBJR%2f8I9VQ&pid=ImgRaw&r=0',
        'isFavorite':0
      },
    ];

    for (final quiz in quizzes) {
      await db.insert('QUIZ', quiz);
    }
  }

  // I N S E R T -- Q U E S T I O N
  Future<void> insertQuestions(Database db) async {
    final questions = [
      // Câu hỏi cho Quiz "Java Basics Quiz" (subject_id = 1)
      {
        'image_url': null,
        'quiz_id': 1,  // Giả sử quiz_id = 1 là "Java Basics Quiz"
        'content': 'What is the size of an int in Java?',
        'answer1': '2 bytes',
        'answer2': '4 bytes',
        'answer3': '8 bytes',
        'answer4': '16 bytes',
        'correct_answer': 2,  // Câu trả lời đúng là answer2
      },
      {
        'image_url': null,
        'quiz_id': 1,  // Giả sử quiz_id = 1 là "Java Basics Quiz"
        'content': 'What is the default value of a boolean in Java?',
        'answer1': 'true',
        'answer2': 'false',
        'answer3': 'null',
        'answer4': '0',
        'correct_answer': 2,  // Câu trả lời đúng là answer2 (false)
      },
      {
        'image_url': null,
        'quiz_id': 1,  // Giả sử quiz_id = 1 là "Java Basics Quiz"
        'content': 'What is a part of OOP in Java?',
        'answer1': 'Encapsulation',
        'answer2': 'Consistency',
        'answer3': 'Immutable',
        'answer4': 'None of above',
        'correct_answer': 1,  // Câu trả lời đúng là answer2 (false)
      },

      // Câu hỏi cho Quiz "Advanced Java Quiz" (subject_id = 1)
      {
        'image_url': null,
        'quiz_id': 2,  // Giả sử quiz_id = 2 là "Advanced Java Quiz"
        'content': 'What is the purpose of the final keyword in Java?',
        'answer1': 'To define a constant',
        'answer2': 'To stop inheritance',
        'answer3': 'To mark a class as abstract',
        'answer4': 'To declare a static variable',
        'correct_answer': 1,  // Câu trả lời đúng là answer1
      },
      {
        'image_url': null,
        'quiz_id': 2,  // Giả sử quiz_id = 2 là "Advanced Java Quiz"
        'content': 'Which of the following is a feature of Java?',
        'answer1': 'Platform-independent',
        'answer2': 'Code is executed directly by the CPU',
        'answer3': 'Requires a specific operating system',
        'answer4': 'None of the above',
        'correct_answer': 1,  // Câu trả lời đúng là answer1
      },

      //Flutter Basics Quiz
      {
        'image_url': null,
        'quiz_id': 3,  // Giả sử quiz_id = 3 là "Flutter Basics Quiz"
        'content': 'What is the main programming language used for Flutter?',
        'answer1': 'Java',
        'answer2': 'Kotlin',
        'answer3': 'Dart',
        'answer4': 'Swift',
        'correct_answer': 3,  // Câu trả lời đúng là answer3
      },
      {
        'image_url': null,
        'quiz_id': 3,  // Giả sử quiz_id = 3 là "Flutter Basics Quiz"
        'content': 'Which widget is used to create a scrollable view in Flutter?',
        'answer1': 'Column',
        'answer2': 'Row',
        'answer3': 'ListView',
        'answer4': 'Container',
        'correct_answer': 3,  // Câu trả lời đúng là answer3
      },

      //Flutter Advanced Quiz
      {
        'image_url': null,
        'quiz_id': 4,
        'content': 'Which is the most difficult state management type in Flutter ?',
        'answer1': 'BloC',
        'answer2': 'Block',
        'answer3': 'Supply',
        'answer4': 'State',
        'correct_answer': 1,  // Câu trả lời đúng là answer3
      },
      {
        'image_url': null,
        'quiz_id': 4,
        'content': 'What is the role of FutureBuilder in Flutter?',
        'answer1': 'Lazy Loading',
        'answer2': 'Async Wait',
        'answer3': 'I don\'t know',
        'answer4': 'None of above',
        'correct_answer': 2,  // Câu trả lời đúng là answer3
      },

      // Câu hỏi cho Quiz "IELTS Listening Quiz" (subject_id = 8)
      {
        'image_url': null,
        'quiz_id': 5,
        'content': 'In the IELTS listening test, what is the maximum number of speakers you will hear?',
        'answer1': '1',
        'answer2': '2',
        'answer3': '3',
        'answer4': '4',
        'correct_answer': 2,  // Câu trả lời đúng là answer2
      },
      {
        'image_url': null,
        'quiz_id': 5,
        'content': 'What is the main focus of the IELTS listening test?',
        'answer1': 'Listening for general understanding',
        'answer2': 'Listening for specific information',
        'answer3': 'Listening for grammar',
        'answer4': 'Listening for pronunciation',
        'correct_answer': 2,  // Câu trả lời đúng là answer2
      },

      // Câu hỏi cho Quiz "IELTS Reading Quiz" (subject_id = 8)
      {
        'image_url': null,
        'quiz_id': 6,
        'content': 'In the IELTS reading test, what type of questions are commonly asked?',
        'answer1': 'Multiple choice questions',
        'answer2': 'True/False/Not Given questions',
        'answer3': 'Matching headings to paragraphs',
        'answer4': 'All of the above',
        'correct_answer': 4,  // Câu trả lời đúng là answer4
      },
      {
        'image_url': null,
        'quiz_id': 6,
        'content': 'What is the purpose of the "True/False/Not Given" questions in the IELTS reading test?',
        'answer1': 'To test understanding of details and facts',
        'answer2': 'To test vocabulary knowledge',
        'answer3': 'To assess your ability to understand the writer\'s opinion',
        'answer4': 'To check your ability to identify the meaning of specific words',
        'correct_answer': 1,
      },


    ];

    for (final question in questions) {
      await db.insert('QUESTION', question);
    }
  }

  // I N S E R T -- C O M P L E T E -- Q U I Z


  // I N S E R T -- F E E D B A C K


  // I N S E R T -- D I S C O U N T

  Future<void> insertDiscounts(Database db) async {
    final discounts = [
      {
        'name':'Try to upgrade rank',
        'value': 10,
        'rank_id': 1,
      },
      {
        'name':'Welcome to Silver Member',
        'value': 20,
        'rank_id': 2,
      },
      {
        'name':'Master Quiz',
        'value': 60,
        'rank_id': 5,
      },
    ];
    for (final discount in discounts) {
      await db.insert('DISCOUNT', discount);
    }
  }

  // I N S E R T -- T Y P E
  Future<void> insertTypes(Database db) async {
    final types = [
      {'name': 'Multiple Choice'},
      {'name': 'True/False'},
    ];
    for (final type in types) {
      await db.insert('TYPE', type);
    }
  }

  // I N S E R T -- S U B J E C T
  Future<void> insertSubjects(Database db) async {
    final subjects = [
      {'name': 'Java Programming'},
      {'name': 'Flutter Programming'},
      {'name': 'Android Programming'},
      {'name': 'IOS Programming'},
      {'name': 'Chinese HSK3'},
      {'name': 'Japanese JLPT N3'},
      {'name': 'Japanese JLPT N4'},
      {'name': 'Ielts'},
    ];
    for (final subject in subjects) {
      await db.insert('SUBJECT', subject);
    }
  }



  //------------------------------------------------------ F U N C T I O N -------------------------------------------------

  // A D D -- U S E R
  Future<int> addNewUser(User user) async {
    List<Map<String,dynamic>> users = await getAllUser();
    for(Map<String,dynamic> u in users){
      if(u['username'] == user.username){
        throw Exception("Username already exists");
      } else if (u['email'] == user.email) {
        throw Exception("Email already exists");
      }
    }
    final db = await instance.database;
    return db.insert('USER', user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> updateRankByScore(int score, int userId) async {
    final db = await instance.database;
    final rankList = await getAllRank();
    int newRankId = 0;

    for(var r in rankList) {
      if(score > r['min_score']) {
        newRankId = r['id'];
      } else {
        break;
      }
    }

    if(newRankId != 0) {
      return db.update('USER', {'rank_id': newRankId},where: 'id = ?', whereArgs: [userId]);
    }
    return 0;
  }

  // U P D A T E -- U S E R
  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return db.update('USER', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  }

  // U P D A T E -- P A S S W O R D
  Future<int> updatePasswordUser(String email, String newPassword) async {
    final db = await instance.database;
    User? user = await getUserByEmail(email);
    String oldPassword = user!.password;
    if(oldPassword == newPassword) {
      throw Exception('Please enter different the old password');
    }
    return db.update('USER', {'password':newPassword}, where: 'id = ?',whereArgs: [user!.id]);
  }


  Future<int> updateUserTotalScore(int score, int userId) async {
    final db = await instance.database;
    try {
      return await db.update('USER', {'total_score':score}, where: 'id = ?', whereArgs: [userId]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  // G E T - A L L - U S E R
  Future<List<Map<String,dynamic>>> getAllUser() async {
    final db = await instance.database;
    return db.query('USER');
  }

  // G E T - A L L - U S E R - DESC
  Future<List<Map<String,dynamic>>> getAllUserByDesc() async {
    final db = await instance.database;
    return db.query('USER',orderBy: 'total_score DESC');
  }


  // G E T - U S E R - B Y - N A M E
  Future<User?> getUserByUsername(String username) async {
    final db = await instance.database;
    final List<Map<String,dynamic>> users = await db.query(
      'USER',
      where: 'username = ?',
      whereArgs: [username]
    );
    if(users.isNotEmpty) {
      //Chuyen phan tu dau tien cua map -> doi tuong
      return User.fromMap(users.first);
    }
    return null;
  }

  // G E T - U S E R - B Y - E M A I L
  Future<User?> getUserByEmail(String email) async {
    final db = await instance.database;
    final List<Map<String,dynamic>> users = await db.query(
        'USER',
        where: 'email = ?',
        whereArgs: [email]
    );
    if(users.isNotEmpty) {
      return User.fromMap(users.first);
    }
    return null;
  }

  // G E T _ P A S S W O R D - B Y - U S E R - I D
  Future<String> getPasswordByUserId(String email) async {
    final db = await instance.database;
    User? user = await getUserByEmail(email);
    return user!.password;
  }

  // G E T - U S E R - B Y - I D
  Future<User?> getUserById(int id) async {
    final db = await instance.database;
    final List<Map<String,dynamic>> users = await db.query(
        'USER',
        where: 'id = ?',
        whereArgs: [id]
    );
    if(users.isNotEmpty) {
      return User.fromMap(users.first);
    }
    return null;
  }


  // [ P I N ]
  Future<int> addNewPin(String password, String email) async {
    final db = await instance.database;
    User? user = await getUserByEmail(email);
    if(user != null) {
      Pin? getPin = await getPinByUserId(user.id!);
      if(getPin != null) {
        print("PIN existed");
        //CHECK TIME
        DateTime realTime = DateTime.now();
        if(realTime.isAfter(getPin.expiredAt!)){
          await deletePinByPinId(getPin.id!);
          print("DELETE EXPIRED PIN");

          //CREATE NEW PIN
          Pin newPin = Pin(userId: user.id!, pinCode: password);

          await db.insert('PIN', newPin.toMap());
          print('DA INSERT NEW PIN');
          return 1;

        } else {
          throw Exception('Error already request for $email');
        }
      } else {
        print("DANG O DAY");
        Pin newPin = Pin(userId: user.id!, pinCode: password);
        await db.insert('PIN', newPin.toMap());
        print('DA INSERT NEW PIN NULL');
        return 1;

      }
    }
    throw Exception('User are not found');
  }

  Future<Pin?> getPinByUserId(int userId) async {
    final db = await instance.database;
    final List<Map<String,dynamic>> pins = await db.query(
        'PIN',
        where: 'user_id = ?',
        whereArgs: [userId]
    );
    if(pins.isNotEmpty) {
      return Pin.fromMap(pins.first);
    }
    return null;
  }

  Future<void> deletePinByPinId(int pinId) async {
    final db = await instance.database;
    db.delete('PIN',where: 'id = ?',whereArgs: [pinId]);
  }



  // [ R A N K ]
  Future<Rank?> getRankByRankId(int rankID) async {
    final db = await instance.database;
    final List<Map<String,dynamic>> ranks = await db.query(
        'RANK',
        where: 'id = ?',
        whereArgs: [rankID]
    );
    if(ranks.isNotEmpty) {
      return Rank.fromMap(ranks.first);
    }
    return null;
  }

  Future<List<Map<String,dynamic>>> getAllRank() async {
    final db = await instance.database;
    return db.query('RANK');
  }


  // [ S U B J E C T]
  Future<List<Map<String,dynamic>>> getAllSubjects() async {
    final db = await DBHelper.instance.database;
    return db.query('SUBJECT');
  }

  Future<int> addNewSubject(Subject subject) async {
    final db = await instance.database;
    final listSubjects = await getAllSubjects();
    bool check = listSubjects.any((items) => items['name'] == subject.name);
    if(check){
      throw Exception('Subject already exist');
    } else {
      return db.insert('SUBJECT', subject.toMap());
    }
  }

  Future<Subject?> getSubjectById(int id) async {
    final db = await instance.database;
    final List<Map<String,dynamic>> subjects = await db.query(
        'SUBJECT',
        where: 'id = ?',
        whereArgs: [id]
    );
    if(subjects.isNotEmpty) {
      return Subject.fromMap(subjects.first);
    }
    return null;
  }


  // [ Q U I Z ]

  //Add Quiz
  Future<int> addNewQuiz(Quiz quiz, int userId) async {
    final db = await DBHelper.instance.database;
    final ownQuiz = await getQuizByUserId(userId);
    final checkAny = ownQuiz.any((items) => items['title'] == quiz.title);
    if(checkAny) {
      throw Exception('Quiz already exist! Try again');
    } else {
      return db.insert('QUIZ', quiz.toMap());
    }
  }

  //Update Quiz
  Future<int> updateQuiz(Quiz quiz, int userId) async {
    final db = await instance.database;
    final ownQuiz = await getQuizByUserId(userId);
    final checkAny = ownQuiz.any((items) => items['id'] == quiz.id && items['user_id'] == userId);
    if(checkAny) {
      return db.update('QUIZ', quiz.toMap());
    } else {
      throw Exception('Quiz not found! Try again');
    }
  }

  //Delete Quiz
  Future<void> deleteQuizById(int id) async {
    final db = await instance.database;
    db.delete('QUIZ',where: 'id = ?', whereArgs: [id]);
  }

  //Get All Quiz
  Future<List<Map<String,dynamic>>> getAllQuiz() async {
    final db = await instance.database;
    return db.query('QUIZ');
  }

  //Get Quiz By Subject Id
  Future<List<Map<String,dynamic>>> getQuizBySubjectId(int subjectId) async {
    final db = await instance.database;
    return db.query('QUIZ',where: 'subject_id = ?', whereArgs: [subjectId]);
  }


  //Get Quiz By User Id
  Future<List<Map<String,dynamic>>> getQuizByUserId(int userId) async {
    final db = await instance.database;
    return db.query('QUIZ',where: 'user_id = ?', whereArgs: [userId]);
  }

  //Update Quiz Favorite Status
  Future<int> updateIsFavorite(int quizId, int status) async {
    final db = await instance.database;
    return db.update(
      'QUIZ',
      {'isFavorite': status}, // Giá trị cần cập nhật
      where: 'id = ?',
      whereArgs: [quizId],
    );
  }

  //Get Quiz By Id
  Future<Quiz?> getQuizById(int quizId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> quizs = await db.query('QUIZ',where: 'id = ?',whereArgs: [quizId]);
    if(quizs.isNotEmpty){
      return Quiz.fromMap(quizs.first);
    } else {
      return null;
    }
  }

  // [ T Y P E ]
  Future<Type?> getTypeById(int typeId) async {
    final db = await DBHelper.instance.database;
    final List<Map<String, dynamic>> types = await db.query('TYPE',where: 'id = ?',whereArgs: [typeId]);
    if(types.isNotEmpty){
      return Type.fromMap(types.first);
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllType() async {
    final db = await DBHelper.instance.database;
    return db.query('TYPE');
  }


  // [ Q U E S T I O N ]
  Future<List<Map<String,dynamic>>> getQuestionListByQuizId(int quizId) async {
    final db = await DBHelper.instance.database;
    return db.query('QUESTION',where: 'quiz_id=?',whereArgs: [quizId]);
  }

  Future<Question?> getQuestionById(int questionId) async {
    final db = await DBHelper.instance.database;
    final List<Map<String,dynamic>> questions = await db.query(
        'QUESTION',
        where: 'id = ?',
        whereArgs: [questionId]
    );
    if(questions.isNotEmpty) {
      return Question.fromMap(questions.first);
    }
    return null;
  }


  // [ F A V O R I T E ]
  Future<int> addNewFavorite(Favorite favorite, int quizId, int userId) async {
    final db = await DBHelper.instance.database;
    final isFavoriteExists = await db.query(
      'FAVORITE',
      where: 'quiz_id = ? AND user_id = ?',
      whereArgs: [quizId, userId],
    );

    if (isFavoriteExists.isNotEmpty) {
      throw Exception('Already existed');
    }
    await DBHelper.instance.updateIsFavorite(quizId, 1);
    return db.insert('FAVORITE', favorite.toMap());
  }

  Future<void> removeFavorite(int quizId, int userId) async {
    final db = await DBHelper.instance.database;
    final isFavoriteExists = await db.query(
      'FAVORITE',
      where: 'quiz_id = ? AND user_id = ?',
      whereArgs: [quizId, userId],
    );

    if (isFavoriteExists.isNotEmpty) {
      // Cập nhật trạng thái isFavorite
      await DBHelper.instance.updateIsFavorite(quizId, 0);

      // Xóa mục yêu thích
      await db.delete(
        'FAVORITE',
        where: 'quiz_id = ? AND user_id = ?',
        whereArgs: [quizId, userId],
      );
    }
  }

  Future<Favorite?> getFavoriteByUserId(int userId) async {
    final db = await DBHelper.instance.database;
    final List<Map<String,dynamic>> favorites = await db.query(
        'FAVORITE',
        where: 'user_id = ?',
        whereArgs: [userId]
    );
    if(favorites.isNotEmpty) {
      return Favorite.fromMap(favorites.first);
    }
    return null;
  }

  Future<List<Map<String,dynamic>>> getAllFavoriteByUserId(int userId) async {
    final db = await DBHelper.instance.database;
    return db.query('FAVORITE',where: 'user_id=?',whereArgs: [userId]);
  }

  Future<List<Map<String,dynamic>>> getAllFavorite() async {
    final db = await DBHelper.instance.database;
    return db.query('FAVORITE');
  }


  // [ C O M P L E T E - Q U I Z ]
  Future<int> createNewCompleteQuiz(CompletedQuiz complete, int userId) async {
    final db = await DBHelper.instance.database;
    final completeList = await DBHelper.instance.getAllCompleteQuizByUserId(userId);
    bool check = completeList.any((items) => items['quiz_id'] == complete.quizId);
    if(check){
      throw Exception('Quiz already join');
    } else {
      return db.insert('COMPLETED_QUIZ', complete.toMap());
    }
  }

  Future<int> updateCompleteQuiz(int score, int userId, int quizId, DateTime dateTime) async {
    final db = await DBHelper.instance.database;
    // final complete = await DBHelper.instance.getCompleteQuizByQuizIdAndUserId(userId);
    // final listComplete = await DBHelper.instance.getAllCompleteQuizByUserId(3);
    // print('DO DAI ${listComplete.length}');
    // bool check = listComplete.any((items) => items['user_id'] == 3 && items['quiz_id'] == 1);
      print('Score SQL: $score');
      print('Complete_at SQL: ${dateTime.toIso8601String()}');
      return db.update(
        'COMPLETED_QUIZ',
        {
          'score': score,
          'completed_at': dateTime.toIso8601String()
        },
        where: 'user_id = ? AND quiz_id = ?',
        whereArgs: [userId, quizId],
      );
    }

    Future<void>deleteCompleteQuiz(int userId, int quizId) async {
      final db = await instance.database;
      await db.delete('COMPLETED_QUIZ',where: 'user_id=? AND quiz_id=?',whereArgs: [userId,quizId]);
    }

  Future<List<Map<String,dynamic>>> getAllCompleteQuizByUserId(int userId) async {
    final db = await DBHelper.instance.database;
    return db.query('COMPLETED_QUIZ',where: 'user_id=?',whereArgs: [userId]);
  }


  Future<CompletedQuiz?> getCompleteQuizByQuizIdAndUserId(int userId) async {
    final db = await DBHelper.instance.database;
    final List<Map<String,dynamic>> completes = await db.query(
        'COMPLETED_QUIZ',
        where: 'user_id = ?',
        whereArgs: [userId]
    );
    print('Complete cua user');
    if(completes.isNotEmpty) {
      return CompletedQuiz.fromMap(completes.first);
    }
    return null;
  }

}
