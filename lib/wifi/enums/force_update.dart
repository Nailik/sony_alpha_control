//actually only for wifi
enum ForceUpdate {
  //force loads Available
  Available,
  //force loads Supported
  Supported,
  //force loads available, supported, current
  Both,
  //force loads the one that is null
  IfNull,
  //do not load
  Off
}
