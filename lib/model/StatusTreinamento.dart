enum StatusTreinamento {
  ANDAMENTO,CONCLUIDO,INSCRITO,CANCELADO,INCOMPLETO,REPROVADO
}

StatusTreinamento statusTreinamentoFromJson(String value) {
  switch (value) {
    case 'ANDAMENTO':
      return StatusTreinamento.ANDAMENTO;
    case 'CONCLUIDO':
      return StatusTreinamento.CONCLUIDO;
    case 'INSCRITO':
      return StatusTreinamento.INSCRITO;
    case 'CANCELADO':
      return StatusTreinamento.CANCELADO;
    case 'INCOMPLETO':
      return StatusTreinamento.INCOMPLETO;
    case 'REPROVADO':
      return StatusTreinamento.REPROVADO;
    default:
      throw ArgumentError('Unknown statusTreinamento value: $value');
  }
}

String statusTreinamentoToJson(StatusTreinamento statusTreinamento) {
  return statusTreinamento.toString().split('.').last;
}