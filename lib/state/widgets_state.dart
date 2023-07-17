import 'package:equatable/equatable.dart';

class WidgetsState extends Equatable{

  final Map<String, bool> widgetState;

  const WidgetsState(this.widgetState);

  @override
  List<Object?> get props => [widgetState];

}