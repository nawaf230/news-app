// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.selectedFile,
    this.userName = 'User Name',
    this.countryName,
    this.countryCode,
  });

  final XFile? selectedFile;
  final String userName;
  final String? countryName;
  final String? countryCode;

  ProfileState copyWith({
    String? userName,
    XFile? selectedFile,
    String? countryName,
    String? countryCode,
  }) {
    return ProfileState(
      selectedFile: selectedFile ?? this.selectedFile,
      userName: userName ?? this.userName,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  @override
  List<Object?> get props => [selectedFile, userName, countryName];
}
