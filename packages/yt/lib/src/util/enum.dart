/// Identifies the new moderation status of the specified comments.
enum ModerationStatus {
  /// Marks a comment as awaiting review by a moderator.
  heldForReview,

  /// Clears a comment for public display.
  published,

  /// Rejects a comment as being unfit for display. This action also effectively
  /// hides all replies to the rejected comment.
  rejected,
}
