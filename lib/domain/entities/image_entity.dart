class ImageEntity {
  double aspectRatio;
  String filePath;
  int height;
  String iso6391;
  double voteAverage;
  int voteCount;
  int width;

  ImageEntity({
    this.aspectRatio,
    this.filePath,
    this.height,
    this.iso6391,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['aspect_ratio'] = aspectRatio;
    data['file_path'] = filePath;
    data['height'] = height;
    data['iso_639_1'] = iso6391;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['width'] = width;
    return data;
  }
}
