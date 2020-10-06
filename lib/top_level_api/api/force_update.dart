//actually only for wifi
enum ForceUpdate {
  //force loads Available
  Available,
  //force loads Supported
  Supported,
  //force loads Current
  Current,
  //force loads available, supported, current
  On,
  //force loads all that are null (available, supported, current)
  IfNull,
}
