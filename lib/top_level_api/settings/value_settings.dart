//a set function is like "fmode" you have available settings and choose one
import 'package:flutter/cupertino.dart';

abstract class ValueSettings extends ChangeNotifier {
  int _value;

  set value(int newValue);

  int get value;

  List<int> available = new List();
  List<int> supported = new List();

  int SettingsType;
}

class FNumberSettings extends ValueSettings{

}
