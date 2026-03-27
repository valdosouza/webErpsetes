abstract class Failure {}

// General failures
class ServerFailure extends Failure {
  final String? detail;

  ServerFailure([this.detail]);

  @override
  String toString() =>
      detail ??
      'Falha ao comunicar com o servidor. Verifique a conexão e tente novamente.';
}

class CacheFailure extends Failure {
  @override
  String toString() => 'Falha ao ler dados locais.';
}
