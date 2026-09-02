import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'failure.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  
  ErrorHandler.handle(dynamic error) {
    if (error is AuthException) {
      failure = _handleSupabaseAuthError(error);
    } else if (error is PostgrestException) {
      failure = _handleSupabasePostgrestError(error);
    } else if (error is StorageException) {
      failure = _handleSupabaseStorageError(error);
    } else {
      failure = DataSource.unknown.toFailure();
    }
    
    if (!kReleaseMode) {
      log("<-------> \n ${error.toString()} \n <------->");
      log("<====> ${failure.code} : ${failure.message} <====>");
    }
  }

  Failure _handleSupabaseAuthError(AuthException error) {
    switch (error.statusCode) {
      case '400':
        if (error.message.contains('Invalid login credentials') ||
            error.message.contains('Email not confirmed')) {
          return DataSource.unautorised.toFailure();
        }
        return DataSource.badRequest.toFailure();
      case '422':
        return DataSource.badRequest.toFailure();
      case '429':
        return DataSource.recieveTimeOut.toFailure();
      default:
        return DataSource.unknown.toFailure();
    }
  }

  Failure _handleSupabasePostgrestError(PostgrestException error) {
    if (error.message.contains('JWT')) {
      return DataSource.unautorised.toFailure();
    }
    
    switch (error.code) {
      case '42501': // insufficient_privilege
        return DataSource.forbidden.toFailure();
      case 'PGRST301': // JWT expired
        return DataSource.unautorised.toFailure();
      default:
        return DataSource.unknown.toFailure();
    }
  }

  Failure _handleSupabaseStorageError(StorageException error) {
    if (error.message.contains('not allowed')) {
      return DataSource.forbidden.toFailure();
    }
    return DataSource.unknown.toFailure();
  }
}

// Keep the rest of your DataSource enum and extensions unchanged
enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unautorised,
  notFound,
  internalServerError,
  recieveTimeOut,
  cacheError,
  noInternetConnection,
  unknown,
  connectionTimeout,
  cancel,
}

extension DataSourceExtention on DataSource {
  Failure toFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unautorised:
        return Failure(ResponseCode.unautorised, ResponseMessage.unautorised);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(
          ResponseCode.internalServerError,
          ResponseMessage.internalServerError,
        );
      case DataSource.recieveTimeOut:
        return Failure(
          ResponseCode.recieveTimeOut,
          ResponseMessage.recieveTimeOut,
        );
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(
          ResponseCode.noInternetConnection,
          ResponseMessage.noInternetConnection,
        );
      case DataSource.unknown:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
      case DataSource.connectionTimeout:
        return Failure(
          ResponseCode.connectionTimeout,
          ResponseMessage.connectionTimeout,
        );
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);
    }
  }
}

// Keep ResponseCode, ResponseMessage, and ApiInternalState unchanged
class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unautorised = 401;
  static const int notFound = 404;
  static const int internalServerError = 500;

  static const int noInternetConnection = -1;
  static const int recieveTimeOut = -2;
  static const int cacheError = -3;
  static const int connectionTimeout = -4;
  static const int unknown = -5;
  static const int cancel = -6;
}

class ResponseMessage {
  static const String success = 'success';
  static const String noContent = 'noContent';
  static const String badRequest = 'badRequest';
  static const String forbidden = 'forbidden';
  static const String unautorised = 'unautorised';
  static const String notFound = 'notFound';
  static const String internalServerError = 'internalServerError';

  static const String noInternetConnection = 'noInternetConnection';
  static const String recieveTimeOut = 'recieveTimeOut';
  static const String connectionTimeout = 'connectionTimeout';
  static const String cacheError = 'cacheError';
  static const String unknown = 'unknown';
  static const String cancel = 'cancel';
}

class ApiInternalState {
  static const success = true;
  static const failure = false;
}