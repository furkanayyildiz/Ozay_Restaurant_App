import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'admin_panel_event.dart';
part 'admin_panel_state.dart';

class AdminPanelBloc extends Bloc<AdminPanelEvent, AdminPanelState> {
  AdminPanelBloc() : super(AdminPanelState()) {
    on<GetUsersListEvent>(_getUserListEvent);
  }

  FutureOr<void> _getUserListEvent(
      GetUsersListEvent event, Emitter<AdminPanelState> emit) {}
}
