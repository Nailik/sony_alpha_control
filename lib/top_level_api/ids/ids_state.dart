enum AutoFocusStateId {
  /// <summary>
  /// Focus state is inactive (no green circle / rings on the screen)
  /// </summary>
  Inactive,

  /// <summary>
  /// Solid green circle
  /// </summary>
  Focused,

  /// <summary>
  /// Blinking solid green circle (the camera cannot focus on the selected subject)
  /// </summary>
  FocusFailed,

  /// <summary>
  /// Green rings
  /// </summary>
  Searching,

  /// <summary>
  /// Solid green circle with green rings
  /// </summary>
  FocusedAndSearching,
  Unknown
}

