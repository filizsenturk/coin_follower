class StatusModel {
  final String timestamp;
  final int errorCode;
  final String errorMessage;
  final int elapsed;
  final int creditCount;
  final String notice;
  final int totalCount;

  StatusModel(
      this.timestamp,
      this.errorCode,
      this.errorMessage,
      this.elapsed,
      this.creditCount,
      this.notice,
      this.totalCount);

  factory StatusModel.fromJson(Map<String, dynamic> json){
    return StatusModel(
        json["timestamp"],
        json["errorCode"],
        json["errorMessage"]==null ? "" : json["errorMessage"],
        json["elapsed"] == null ? 0 : json["elapsed"],
        json["creditCount"],
        json["notice"]==null ? "" : json["notice"],
        json["totalCount"]);
  }
}
