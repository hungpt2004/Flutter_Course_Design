import 'package:course_app_flutter/provider/document_provider.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:course_app_flutter/theme/data/style_button.dart';
import 'package:course_app_flutter/theme/data/style_image.dart';
import 'package:course_app_flutter/views/document/widget/document_content_widget.dart';
import 'package:flutter/material.dart';
import '../../constant/color.dart';
import '../../theme/data/style_text.dart';

class DocumentScreen extends StatefulWidget {
  const DocumentScreen({super.key});

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  @override
  Widget build(BuildContext context) {

    final documentProvider = DocumentProvider.documentStateManagement(context);
    final loadingProvider = LoadingProvider.stateLoadingProvider(context);

    return Scaffold(
      appBar: TextStyleApp.appbarStyle("Course Docs"),
      backgroundColor: homeBackgroundColor,
      body: FutureBuilder<void>(
          future: documentProvider.getAllDocuments(),
          builder: (context, snapshot) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: documentProvider.documents.length,
                itemBuilder: (context, index) {
                    final documentList = documentProvider.documents;
                    final cardIndex = documentList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Card(
                        color: index % 2 == 0 ? kDefaultColor : Colors.orange.withOpacity(0.9),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Container(
                                  width: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: ImageNetworkStyle.networkImage(cardIndex.url)
                                  ),
                                ),
                                title: Text(
                                  cardIndex.title,
                                  style: TextStyleApp.textStyleForm(
                                      16, FontWeight.w700, index % 2 == 0 ? kPrimaryColor : kDefaultColor),
                                ),
                                trailing: IconButton(onPressed: (){
                                  loadingProvider.toggleExpanded(index);
                                }, icon: loadingProvider.currentIndex == index ? const Icon(Icons.keyboard_arrow_down) : const Icon(Icons.keyboard_arrow_up) ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: loadingProvider.currentIndex == index ? (70.0 * cardIndex.contents.length) : 0,
                              child: loadingProvider.currentIndex == index
                                  ? CardDocument(contents: cardIndex.contents,)
                                  : null,
                            )
                          ],
                        ),
                      ),
                    );
                },
              ),
            );
          }
      ),
    );
  }
}



