class Pin {
  final String? pin;
  final String? expireAt;

  Pin({required this.pin, required this.expireAt});

  Map<String,dynamic> toFirebase(){
    return {
      'pin':pin,
      'expire_at':expireAt
    };
  }

  factory Pin.fromFirebase(Map<String, dynamic> firebase) {
    return Pin (
      pin: firebase['pin'] ?? 'nothing',
      expireAt: firebase['expire_at'] ?? 'nothing'
    );
  }

}