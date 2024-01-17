class ArticleModel {
  final int id;             // The item's unique id.
  final String ? type;      // The type of item. One of "job", "story", "comment", "poll", or "pollopt".
  final String ? author;    // The username of the item's author.
  final String title;       // The title of the story, poll or job. HTML.
  final String ? url;       // The URL of the story.
  final int ? score;        // The story's score, or the votes for a pollopt.
  final int ? time;         // Creation date of the item, in Unix Time.
  final int ? descendants;  // In the case of stories or polls, the total comment count.

  /// constructor
  ArticleModel({
    required this.id,
    required this.title,
    this.author,
    this.type,
    this.url,
    this.score,
    this.time,
    this.descendants
  });

  /// Convert JSON to model
  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'],
      type: map['type'] ?? '',
      author: map['by'] ?? '',
      title: map['title'],
      url: map['url'] ?? '',
      score: map['score'] ?? 0,
      time: map['time'] ?? 0,
      descendants: map['descendants'] ?? 0,
    );
  }
}
