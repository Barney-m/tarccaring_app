class Feedbacks {
  String feedback_id, creator_id, handler_id, status;
  int feedbackType_id;
  bool anonymous;
  DateTime created_date, approve_date, dismiss_date, last_modified;

  Feedbacks(
      this.feedback_id,
      this.feedbackType_id,
      this.creator_id,
      this.handler_id,
      this.anonymous,
      this.created_date,
      this.approve_date,
      this.dismiss_date,
      this.last_modified,
      this.status);

  Feedbacks.approvedContent(
      this.feedback_id,
      this.feedbackType_id,
      this.creator_id,
      this.anonymous,
      this.created_date,
      this.approve_date,
      this.status);

  Feedbacks.dismissedContent(
      this.feedback_id,
      this.feedbackType_id,
      this.creator_id,
      this.anonymous,
      this.created_date,
      this.approve_date,
      this.status);

  Map<String, dynamic> toMap() {
    return {
      'feedback_id': feedback_id,
      'feedbackType_id': feedbackType_id,
      'creator_id': creator_id,
      'handler_id': handler_id,
      'anonymous': anonymous,
      'created_date': created_date,
      'approve_date': approve_date,
      'dismiss_date': dismiss_date,
      'last_modified': last_modified,
      'status': status,
    };
  }
}
