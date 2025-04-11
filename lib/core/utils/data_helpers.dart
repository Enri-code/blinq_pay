import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';

///[FutureEitherFailureOr] is a type alias for a Future that returns either
///a Failure or a value of type T.
/// It is used to handle asynchronous operations that can fail.
typedef FutureEitherFailureOr<T> = Future<Either<Failure, T>>;

///[Status] is used to handle the status of the data
enum Status { initial, loading, error, success }

///[Failure] is used to handle errors in the app
/// It contains an error message and an optional error code.
class Failure extends Equatable {
  final int? errorCode;
  final String message;
  
  const Failure(this.message, [this.errorCode]);

  @override
  List<Object?> get props => [errorCode, message];
}

///[DataState] contains the status of the data (initial, loading, failed, success)
/// and an optional error message.
/// It is used to handle the state of the data in the UI
class DataState extends Equatable {
  final Status status;
  final Failure? error;

  const DataState({this.status = Status.initial, this.error});

  @override
  List<Object?> get props => [status, error];
}

///[PaginationData] is used to handle pagination data
/// It contains the current page, the data for that page, and a boolean indicating if there is a next page.
class PaginationData<T> extends Equatable {
  final int page;
  final List<T> data;
  final bool hasNextPage;

  const PaginationData({
    this.page = 0,
    this.hasNextPage = false,
    this.data = const [],
  });

  @override
  List<Object?> get props => [page, data, hasNextPage];
}
