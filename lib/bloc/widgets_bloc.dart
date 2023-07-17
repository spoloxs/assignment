import 'package:assignment/state/widgets_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetBloc extends Cubit<WidgetsState> {
  WidgetBloc() : super(const WidgetsState({
      "textBox": false,
      "imageBox": false,
      "saveButton": false
    }));
  
  unlockWidget(bool textBox, bool imageBox, bool saveButton){
    Map<String, bool> temp = {
      "textBox": textBox,
      "imageBox": imageBox,
      "saveButton": saveButton
    };
    emit(WidgetsState(temp));
  }
}
