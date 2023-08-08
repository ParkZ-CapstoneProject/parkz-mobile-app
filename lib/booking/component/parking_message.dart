class ParkingServiceText {
  final String line1;
  final String line2;
  final String line3;
  final String thankYouMessage;

  ParkingServiceText({
    required this.line1,
    required this.line2,
    required this.line3,
    required this.thankYouMessage,
  });
}



final parkingServiceText = ParkingServiceText(
  line1: "- Bạn chỉ có thể đến sớm hơn giờ đặt 1 tiếng.",
  line2:
  "- Đừng ra bãi xe muộn hơn giờ bạn đặt, bạn sẽ bị cảnh báo và tính thêm tiền đấy, nên hãy chọn khoảng thời gian cho thư thả bạn nhé.",
  line3:
  "- Hãy nhớ đến bãi xe và check-in bằng QR nhé, nếu không đến bãi sau khi đặt, bạn sẽ bị ngưng sử dụng dịch vụ.",
  thankYouMessage:
  "Cảm ơn bạn đã sử dụng dịch vụ đỗ xe của chúng tôi, hy vọng bạn có một trải nghiệm thuận tiện và dễ dàng.",
);
