part of 'sidebar_cubit.dart';

class SidebarState extends Equatable {
  final bool isExpanded;

  const SidebarState({this.isExpanded = true});

  @override
  List<Object> get props => [isExpanded];

  SidebarState copyWith({bool? isExpanded}) {
    return SidebarState(isExpanded: isExpanded ?? this.isExpanded);
  }
}
