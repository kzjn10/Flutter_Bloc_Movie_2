import 'dart:io';

import 'package:insurance/common/exceptions/network_connection_exception.dart';
import 'package:insurance/common/network/network_info.dart';
import 'package:insurance/data/datasources/remote/user_remote_datasource.dart';
import 'package:insurance/data/models/account_entity_model.dart';
import 'package:insurance/data/models/inbox_model.dart';
import 'package:insurance/data/models/otp_entity_model.dart';
import 'package:insurance/domain/entities/account_entity.dart';
import 'package:insurance/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkInfoImpl networkInfo;
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl(this.networkInfo, this.userRemoteDataSource);

  @override
  Future<OtpModel> checkOtp(String phoneNumber, String otp) async {
    if (await networkInfo.isConnected) {
      final result = await userRemoteDataSource.checkOtp(phoneNumber, otp);
      return result;
    }
    throw NetworkConnectionException();
  }

  @override
  Future<AccountModel> getUserInfo(String phoneNumber, String token) async {
    if (await networkInfo.isConnected) {
      return userRemoteDataSource.getUserInfo(phoneNumber, token);
    }
    throw NetworkConnectionException();
  }

  @override
  Future<OtpModel> sendOtp(String phoneNumber) async {
    if (await networkInfo.isConnected) {
      return userRemoteDataSource.sendOtp(phoneNumber);
    }
    throw NetworkConnectionException();
  }

  @override
  Future<AccountModel> updateUserInfo(AccountEntity accountData) async {
    if (await networkInfo.isConnected) {
      return userRemoteDataSource.updateUserInfo(accountData);
    }
    throw NetworkConnectionException();
  }

  @override
  Future<String> uploadIdentifyPhoto(String phoneNumber, File photoFile) async {
    if (await networkInfo.isConnected) {
      return userRemoteDataSource.uploadIdentifyPhoto(phoneNumber, photoFile);
    }
    throw NetworkConnectionException();
  }

  @override
  Future<void> registerToken(
      String userToken, String firebaseToken, String phoneNumber) async {
    if (await networkInfo.isConnected) {
      await userRemoteDataSource.registerToken(
          userToken, firebaseToken, phoneNumber);
      return;
    }
    throw NetworkConnectionException();
  }

  @override
  Future<List<InboxModel>> getInbox({int page}) async {
    if (await networkInfo.isConnected) {
      return userRemoteDataSource.getInbox();
    }
    throw NetworkConnectionException();
  }

  @override
  Future<InboxModel> getInboxInfo({String id}) async {
    if (await networkInfo.isConnected) {
      return userRemoteDataSource.getInboxInfo(id);
    }
    throw NetworkConnectionException();
  }
}
