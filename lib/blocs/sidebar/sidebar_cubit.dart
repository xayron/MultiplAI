import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'sidebar_state.dart';

class SidebarCubit extends Cubit<SidebarState> {
  SidebarCubit() : super(const SidebarState(isExpanded: true));

  void toggleSidebar() {
    emit(state.copyWith(isExpanded: !state.isExpanded));
  }
}
