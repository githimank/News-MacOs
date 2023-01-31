class ApiRoutes {
  static String baseUrl = "https://newsapi.org/v2/";
  static String apiKey = "460cc552bcfa44a094a6b857b10c061c";
  String news = "${baseUrl}everything?apiKey=$apiKey";
  String newsTopHeadlines = "${baseUrl}top-headlines?country=in&apiKey=$apiKey";
  String newsByCategory = "${baseUrl}top-headlines?apiKey=$apiKey";
}
