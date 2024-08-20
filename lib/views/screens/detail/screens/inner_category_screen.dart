import 'package:flutter/material.dart';
import 'package:multi_store_app/models/categroy_model.dart';

class InnerCategoryScreen extends StatefulWidget {
  const InnerCategoryScreen({super.key, required this.category});
  final Category category;
  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.20,
        child: Stack(
          children: [
            Image.asset(
              'assets/icons/searchBanner.jpeg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: -6,
              top: 56,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 40,
              top: 40,
              child: SizedBox(
                width: 250,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter text',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF7F7F7F),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      prefixIcon: Image.asset('assets/icons/searc1.png'),
                      suffixIcon: Image.asset('assets/icons/cam.png'),
                      fillColor: Colors.grey.shade200,
                      focusColor: Colors.black,
                      filled: true),
                ),
              ),
            ),
            Positioned(
                left: 290,
                top: 78,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    child: Ink(
                      width: 31,
                      height: 31,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/bell.png'),
                        ),
                      ),
                    ),
                  ),
                )),
            Positioned(
                left: 330,
                top: 78,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    child: Ink(
                      width: 31,
                      height: 31,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/message.png'),
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
