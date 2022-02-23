const repositoryException = 0;
const noInternet = 1;
const unauthorized = 2;
const serverError = 3;
const unknown = 4;

abstract class RepositoryFailure {
  RepositoryFailure([List properties = const <dynamic>[]]) : super();
}

class RepositoryException extends RepositoryFailure {}

class NoInternet extends RepositoryFailure {}

class Unauthorized extends RepositoryFailure {}

class ServerError extends RepositoryFailure {}

class Unknown extends RepositoryFailure {}
