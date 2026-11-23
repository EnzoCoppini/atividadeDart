// Exercício 1: Abstração e Classes de Apoio
class Passageiro {
  String? nome;
  String? cpf;
  String? rg;
  String? email;
  String? celular;

  Passageiro({this.nome, this.cpf, this.rg, this.email, this.celular});
}

class PlataformaVenda {
  int? codigoCanal;
  String? nomeCanal;

  PlataformaVenda({this.codigoCanal, this.nomeCanal});
}

class Atendente {
  String? nome;
  String? matricula;
  String? cargo;
  String? email;
  String? celular;
  double? salario;

  Atendente({
    this.nome,
    this.matricula,
    this.cargo,
    this.email,
    this.celular,
    this.salario,
  });
}

// Exercício 2: Agregação e Construtor Não Nomeado
class Passagem {
  String? _codigoLocalizador = '';
  Passageiro? passageiro;
  PlataformaVenda? plataforma;
  Atendente? atendente;
  String? observacoes;

  Passagem();

  // Exercício 3: Flexibilização com Construtores Nomeados
  Passagem.somenteCodigo(String codigoLocalizador) {
    _codigoLocalizador = codigoLocalizador;
  }

  Passagem.completa(
    this._codigoLocalizador,
    this.passageiro,
    this.plataforma,
    this.atendente,
    this.observacoes,
  );

  // Exercício 4: Parâmetros Nomeados e Clareza de Inicialização
  Passagem.codigoEPassageiro({String? codigoLocalizador, this.passageiro}) {
    _codigoLocalizador = codigoLocalizador;
  }

  Passagem.all(
    this._codigoLocalizador, {
    required this.passageiro,
    required this.plataforma,
    required this.atendente,
    this.observacoes,
  });

  // Exercício 5: Encapsulamento de Atributos Críticos
  String? getCodigoLocalizador() {
    return _codigoLocalizador;
  }

  void setCodigoLocalizador(String? codigoLocalizador) {
    if (codigoLocalizador == null || codigoLocalizador.isEmpty) {
      print("Código localizador de passagem inválido!");
      return;
    }
    _codigoLocalizador = codigoLocalizador;
  }

  // Exercício 6: Refatoração para Getters e Setters nativos do Dart
  String? get codigoLocalizador => _codigoLocalizador;

  set codigoLocalizador(String? codigoLocalizador) {
    if (codigoLocalizador == null || codigoLocalizador.isEmpty) {
      print("Código localizador de passagem inválido!");
      return;
    }
    _codigoLocalizador = codigoLocalizador;
  }

  // Exercício 7: Comportamentos e Métodos de Negócio
  void EmitirPassagem() {
    print("Passagem emitida com sucesso!");
  }

  bool CancelarPassagem() {
    print("Passagem cancelada com sucesso!");
    return true;
  }

  void AtualizarPassagem() {
    print("Passagem atualizada com sucesso!");
  }

  Passagem ConsultarPassagem(String codigo) {
    print("Passagem consultada com sucesso!");
    return Passagem();
  }
}

// Exercício 9: Reutilização de Código com Mixins
mixin Logger {
  void log(String mensagem) {
    print(mensagem);
  }
}

mixin Auditoria {
  void auditar(String mensagem) {
    print("[Auditoria]: $mensagem");
  }
}

// Exercício 8: Especialização com Herança
// Exercício 9: Aplicação dos Mixins (Logger e Auditoria)
class PassagemPrimeiraClasse extends Passagem with Logger, Auditoria {
  String? loungeAcesso;

  PassagemPrimeiraClasse(
    String? codigoLocalizador,
    Passageiro? passageiro,
    PlataformaVenda? plataforma,
    Atendente? atendente,
    String? observacoes, {
    required this.loungeAcesso,
  }) : super.all(
          codigoLocalizador,
          passageiro: passageiro,
          plataforma: plataforma,
          atendente: atendente,
          observacoes: observacoes,
        );

  // Exercício 10: Sobrescrita Polimórfica
  @override
  void AtualizarPassagem() {
    print("Passagem de Primeira Classe atualizada com sucesso!");
    log("Atendente: ${super.atendente?.nome}");
    auditar("Verificação de segurança efetuada para Primeira Classe.");
  }
}

// Exercício 10: Execução Geral
void main() {
  Passageiro passageiro = Passageiro(
    nome: "Carlos Silva",
    cpf: "123.456.789-00",
    rg: "12.345.678-9",
    email: "carlos@email.com",
    celular: "(11) 98765-4321",
  );

  PlataformaVenda plataforma = PlataformaVenda(
    codigoCanal: 1,
    nomeCanal: "Site SkyHorizon",
  );

  Atendente atendente = Atendente(
    nome: "Mariana Souza",
    matricula: "AT123",
    cargo: "Atendente VIP",
    email: "mariana@skyhorizon.com",
    celular: "(11) 91234-5678",
    salario: 4500.0,
  );

  Passagem p1 = Passagem();
  p1.EmitirPassagem();

  Passagem p2 = Passagem.all(
    "SKY123",
    passageiro: passageiro,
    plataforma: plataforma,
    atendente: atendente,
    observacoes: "Sem observações",
  );
  p2.codigoLocalizador = "";
  p2.codigoLocalizador = "SKY999";
  print("Código localizador p2: ${p2.codigoLocalizador}");
  p2.AtualizarPassagem();
  p2.CancelarPassagem();
  p2.ConsultarPassagem("SKY999");

  PassagemPrimeiraClasse pVip = PassagemPrimeiraClasse(
    "SKYVIP01",
    passageiro,
    plataforma,
    atendente,
    "VIP Lounge",
    loungeAcesso: "Sala VIP Terminal 3",
  );
  print("Lounge VIP: ${pVip.loungeAcesso}");
  pVip.AtualizarPassagem();
}
