class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent({this.image, this.title, this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'كن آمن انت ومن حولك',
      image: 'assets/images/onbording1.png',
      discription:
          "• يعلمك هذا التطبيق اذا كنت بالقرب من شخص مصاب بفيروس كورونا "),
  UnbordingContent(
      title: 'تتلقى إشعاراً لوجود خطر الأصابة بفيروس كورونا',
      image: 'assets/images/onbording2.png',
      discription:
          "يخبرك التطبيق اذا خالطت شخص مصاب في الأيام القليلة الماضية بفيروس كورونا لمدة 15 دقيقة على الأقل بشرط استخدام الشخص المصاب هذا التطبيق "),
  UnbordingContent(
    title: 'التطبيق يستخدم الموقع الجغرافي ',
    image: 'assets/images/onbording3.png',
    discription:
        "يستخدم التطبيق تقنية الموقع الجغرافي في تحديد مدى قربك من الشخص الاخر عن طريق قرب موقعك جغرافي",
  ),
];
