import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  CompanyPage({Key? key}) : super(key: key);

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("มหาวิทยาลัยราชภัฏมหาสารคาม"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/images/New-Business-scaled.jpeg'),
              fit: BoxFit.cover,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "มหาวิทยาลัยราชภัฏมหาสารคาม",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    const Text(
                      "เพื่อผลิตบัณฑิตที่มีคุณธรรม จริยธรรม มีจิตสาธารณะ มีความรู้ความสามารถและทักษะในระดับมาตรฐานสากล รู้เท่าทันการเปลี่ยนแปลงของสังคมอย่างมีเหตุผล และส่งเสริมสนับสนุนการขยายโอกาสทางการศึกษาให้แก่ผู้พิการ ผู้มีความสามารถพิเศษ บุคลากรประจำการ และประชาชนทั่วไป",
                      textAlign: TextAlign.left,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[
                            Icon(Icons.phone_android_outlined,
                                color: Colors.orange)
                          ],
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text("มหาวิทยาลัยราชภัฎมหาสารคาม"),
                              ],
                            ),
                            Row(
                              children: const [
                                Text("043-722118"),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Wrap(
                      spacing: 5,
                      children: List.generate(
                        5,
                        (int index) => Chip(
                          label: Text("Text ${index + 1}"),
                          avatar: const Icon(Icons.ac_unit_sharp),
                          backgroundColor: Colors.purpleAccent,
                        ),
                      ),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/happy.png'),
                          radius: 40,
                        ),
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/happy.png'),
                          radius: 40,
                        ),
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/happy.png'),
                          radius: 40,
                        ),
                        SizedBox(
                          width: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: const [
                              Icon(Icons.ac_unit),
                              Icon(Icons.access_alarm_outlined),
                              Icon(Icons.access_time_filled),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
