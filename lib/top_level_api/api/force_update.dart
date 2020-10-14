//actually only for wifi
enum ForceUpdate {
  //force loads Available
  Available,//TODO update only if supported or if available`??
  //force loads Supported
  Supported, //TODO update only if supported or if available`??
  //force loads Current
  Current,
  //force loads available, supported, current
  On,
  //force loads all that are null (available, supported, current)
  IfNull,
}
