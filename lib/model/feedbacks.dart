class Feedbacks {
  String creator_id, handler_id, status, feedback_type, choice, comment, attachment;
  int feedback_id, feedbackType_id;
  bool anonymous;
  DateTime created_at, approved_date, dismiss_date, updated_at;

  Feedbacks(this.feedback_id,this.feedbackType_id, this.choice, this.comment, this.attachment, this.creator_id,this.handler_id,this.anonymous, this.status, this.created_at, this.updated_at, this.approved_date,this.dismiss_date);
  Feedbacks.withType(this.feedback_id,this.feedbackType_id, this.choice, this.comment, this.attachment, this.creator_id,this.handler_id,this.anonymous, this.status, this.created_at, this.updated_at, this.approved_date,this.dismiss_date, this.feedback_type);

  
}
