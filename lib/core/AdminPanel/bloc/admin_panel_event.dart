part of 'admin_panel_bloc.dart';

abstract class AdminPanelEvent extends Equatable {
  const AdminPanelEvent();

  @override
  List<Object> get props => [];
}

class GetUsersListEvent extends AdminPanelEvent {
  const GetUsersListEvent();
}
