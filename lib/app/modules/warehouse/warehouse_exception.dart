class WarehouseException implements Exception {
  final String _message;

  WarehouseException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}