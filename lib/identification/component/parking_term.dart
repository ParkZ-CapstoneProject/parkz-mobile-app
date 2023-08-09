import 'package:flutter/material.dart';
import 'package:parkz/utils/constanst.dart';
import 'package:parkz/utils/text/semi_bold.dart';

class ParkingTermsScreen extends StatelessWidget {
  const ParkingTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Điều khoản và Chính sách '),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SemiBoldText(text: 'Điều khoản và Chính sách Bảo mật khi sử dụng giấy tờ tùy thân', fontSize: 20, color: AppColor.navy, maxLine: 4),
              SizedBox(height: 16,),
              Text(
                "1. Mục đích lưu trữ thông tin:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Thông tin đến khách hàng sẽ được lưu trữ trên hệ thống của ParkZ nhằm xác nhận và quản lý việc đăng ký sử dụng dịch vụ của khách hàng. Thông tin này bao gồm hình ảnh giấy tờ tùy thân, chẳng hạn như Chứng minh thư nhân dân, Căn cước công dân, để xác thực danh tính của khách hàng.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "2. Bảo vệ thông tin cá nhân:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Chúng tôi cam kết bảo vệ thông tin cá nhân của khách hàng và không tiết lộ hoặc chia sẻ thông tin này với bất kỳ bên thứ ba nào, trừ khi có yêu cầu hợp pháp từ cơ quan chức năng hoặc khi khách hàng đã đồng ý cho việc chia sẻ thông tin.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "3. Xác thực và rút gọn thao tác đăng ký:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Thông tin của khách hàng được sử dụng để rút gọn thao tác đăng ký sử dụng dịch vụ và lưu trữ nhằm mục đích xác thực. Khi khách hàng cần sử dụng dịch vụ, hệ thống sẽ sử dụng thông tin đã lưu trữ để xác thực danh tính, giúp tiết kiệm thời gian và tăng tính tiện lợi cho quy trình đăng ký.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "4. Không sử dụng mục đích thương mại:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "ParkZ cam kết không sử dụng thông tin hình ảnh giấy tờ tùy thân cho bất kỳ mục đích thương mại hay quảng cáo nào. Thông tin này chỉ được sử dụng nội bộ để hỗ trợ việc xác thực và quản lý dịch vụ của khách hàng.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "5. Sự đồng ý khi cung cấp cho bên thứ 3:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Chỉ khi có sự đồng ý của khách hàng, chúng tôi có thể cung cấp thông tin hình ảnh giấy tờ tùy thân cho bên thứ 3 với mục đích xác thực hoặc các hoạt động pháp lý liên quan đến việc sử dụng dịch vụ của ParkZ.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "6. Quyền truy cập và yêu cầu xóa thông tin:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Khách hàng có quyền truy cập, cập nhật và yêu cầu xóa thông tin cá nhân của mình khỏi hệ thống ParkZ bất cứ lúc nào. Chúng tôi đảm bảo sẽ thực hiện các yêu cầu này một cách nhanh chóng và chính xác.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                "7. Chấp nhận điều khoản và chính sách bảo mật:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Việc cung cấp thông tin hình ảnh giấy tờ tùy thân đồng nghĩa với việc khách hàng đồng ý và chấp nhận các điều khoản sử dụng thông tin cá nhân nêu trên. Khách hàng cần đọc và hiểu rõ các điều khoản và chính sách bảo mật trước khi sử dụng dịch vụ của ParkZ.",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}