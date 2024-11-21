class Ticket {
  String title;
  String content;
  String url;

  Ticket(this.title, this.content, this.url);

}

List<Ticket> ticketList = [
  Ticket('Hotels', '8% Off', 'hotel_ticket.svg'),
  Ticket('Earn Trip Coins', 'Up to US\$6', 'gold.svg'),
  Ticket('Tours & Tickets', '5% Off', 'tour_ticket.svg'),
  Ticket('Mainland & HK Trains', '3% Off', 'train_ticket.svg'),
  Ticket('Car Rentals', '8% Off', 'car_ticket.svg'),
  Ticket('Airport Transfers', '12% Off', 'plane_ticket.svg'),
];