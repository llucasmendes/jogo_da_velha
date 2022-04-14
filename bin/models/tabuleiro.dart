import 'dart:io';

import '../game/artificial_player.dart';
import 'jogador.dart';

class Tabuleiro {
  var soma = 0;
  var total = 0;
  var _contador = 0;
  var jogoFinalizado = false;
  List<List<String>> coordenadas = [
    ['1', '2', '3'],
    ['4', '5', '6'],
    ['7', '8', '9'],
  ];
  List<List<int>> valores = [
    [0, 0, 0],
    [0, 0, 0],
    [0, 0, 0],
  ];

  void reset() {
    stdin.readLineSync();

    valores = [
      [0, 0, 0],
      [0, 0, 0],
      [0, 0, 0],
    ];
    coordenadas = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
    ];
    jogoFinalizado = false;
    total = 0;
    soma = 0;
    _contador = 0;
  }

  void gerarTabuleiro() {
    stdout.write('\n');
    for (var i = 0; i < 3; i++) {
      stdout.write('\t');
      if (i < 4) {
        for (var j = 0; j < 3; j++) {
          stdout.write(' ${coordenadas[i][j]} ');
          if (j % 2 != 0 || j == 0) {
            stdout.write('|');
          }
        }
        if (i < 2) stdout.write('\n\t-----------');
      }
      stdout.write('\n');
    }
  }

  void setElementoCoordenada(List<int>? local, int? valor) {
    if (local == null) {
      stdout.write('\nCoordenada inválida!\n');
      return;
    }
    if (valor! % 2 == 0 && valores[local[0]][local[1]] == 0) {
      coordenadas[local[0]][local[1]] = '\x1B[33mX\x1B[0m';
      valores[local[0]][local[1]] = 1;
    } else if (valor % 2 != 0 && valores[local[0]][local[1]] == 0) {
      coordenadas[local[0]][local[1]] = '\x1B[31mO\x1B[0m';
      valores[local[0]][local[1]] = -1;
    } else {
      stdout.write('\n\x1B[31mCoordenada já usada!\x1B[0m\n');
    }
  }

  void verificaVencedor(Jogador jogador) {
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        total += valores[i][j];
      }
    }
    if ((total != 1 || total != -1) && _contador >= 9) {
      print("\x1B[2J\x1B[0;0H");
      gerarTabuleiro();
      stdout.write('\nO Jogo terminou em empate!\n\n');
      // jogoFinalizado = true;
      // exit(0);
      reset();
    }
    for (var i = 0; i < 3; i++) {
      soma = 0;
      for (var j = 0; j < 3; j++) {
        soma += valores[i][j];
        if (soma == 3) {
          print("\x1B[2J\x1B[0;0H");
          gerarTabuleiro();
          stdout.write('\nO jogador ${jogador.nome} venceu!\n\n');
          jogoFinalizado = true;
          jogador.score++;
          exit(0);
          // reset();
        } else if (soma == -3) {
          print("\x1B[2J\x1B[0;0H");
          gerarTabuleiro();
          stdout.write('\nO jogador ${jogador.nome} venceu!\n\n');
          jogoFinalizado = true;
          jogador.score++;
          exit(0);
          // reset();
        }
      }
    }

    for (var i = 0; i < 3; i++) {
      soma = 0;
      for (var j = 0; j < 3; j++) {
        soma += valores[j][i];
        if (soma == 3) {
          print("\x1B[2J\x1B[0;0H");
          gerarTabuleiro();
          stdout.write('\nO jogador ${jogador.nome} venceu!\n\n');
          jogoFinalizado = true;
          jogador.score++;
          exit(0);
          // reset();
        } else if (soma == -3) {
          print("\x1B[2J\x1B[0;0H");
          gerarTabuleiro();
          stdout.write('\nO jogador ${jogador.nome} venceu!\n\n');
          jogoFinalizado = true;
          jogador.score++;
          exit(0);
          // reset();
        }
      }
    }

    if (valores[0][0] + valores[1][1] + valores[2][2] == 3) {
      print("\x1B[2J\x1B[0;0H");
      gerarTabuleiro();
      stdout.write('\nO jogador ${jogador.nome} venceu!\n\n');
      jogoFinalizado = true;
      jogador.score++;
      exit(0);
      // reset();
    } else if (valores[0][0] + valores[1][1] + valores[2][2] == -3) {
      print("\x1B[2J\x1B[0;0H");
      gerarTabuleiro();
      stdout.write('\nO jogador ${jogador.nome} venceu!\n\n');
      jogoFinalizado = true;
      jogador.score++;
      exit(0);
      // reset();
    }
    if (valores[0][2] + valores[1][1] + valores[2][0] == 3) {
      print("\x1B[2J\x1B[0;0H");
      gerarTabuleiro();
      stdout.write('\nO jogador ${jogador.nome} venceu!\n\n');
      jogoFinalizado = true;
      jogador.score++;
      exit(0);
      // reset();
    } else if (valores[0][2] + valores[1][1] + valores[2][0] == -3) {
      print("\x1B[2J\x1B[0;0H");
      gerarTabuleiro();
      stdout.write('\nO jogador ${jogador.nome} venceu!\n\n');
      jogoFinalizado = true;
      jogador.score++;
      exit(0);
      // reset();
    }
  }

  void showWellcome() {
    print('\n\n\t\x1B[32mBem vindo ao jogo da velha!\x1B[0m');
    print('\x1B[34mPrimeiro, escolha os nomes dos jogadores...\x1B[0m');
  }

  List<Jogador> setPlayersName() {
    stdout.write('\n');
    stdout.write('Jogador 1: ');
    var player1 = stdin.readLineSync();
    stdout.write('\n');
    stdout.write('Jogador 2: ');
    var player2 = stdin.readLineSync();
    stdout.write(
        '\x1B[36m\n---------------- Vamos Jogar---------------------\n\n\x1B[0m');
    return [
      Jogador(nome: player1!),
      Jogador(nome: player2!),
    ];
  }

  List<int>? getInput(Jogador jogador) {
    late int numero;
    RegExp hexColor = RegExp(r'^[1-9]$');
    stdout.write('\n');
    stdout.write('${jogador.nome}, Digite o número da coordenada: ');
    late String? coordenada;
    coordenada = stdin.readLineSync();
    if (coordenada == 's') {
      exit(0);
    }
    while (coordenada == null || !hexColor.hasMatch(coordenada)) {
      stdout.write('\n\x1B[31mCoordenada inválida!\x1B[0m\n');
      stdout.write('\n\x1B[36mDigite outra:\x1B[0m ');
      coordenada = stdin.readLineSync();
    }
    numero = int.parse(coordenada);
    Map<int, List<int>> mapa = {
      1: [0, 0],
      2: [0, 1],
      3: [0, 2],
      4: [1, 0],
      5: [1, 1],
      6: [1, 2],
      7: [2, 0],
      8: [2, 1],
      9: [2, 2],
    };

    return mapa[numero];
  }

  void jogarContraMaquina({
    required List<Jogador> jogadores,
    required ArtificialPlayer player,
  }) {
    while (true) {
      if (jogoFinalizado) {
        _contador = 0;
      }
      if (_contador != 0) {
        stdout.write('\n');
        stdout.write(
            '${jogadores[0].nome} - \x1B[32m${jogadores[0].score}\x1B[0m\n');
        stdout.write(
            '${jogadores[1].nome} - \x1B[32m${jogadores[1].score}\x1B[0m\n');
      }
      if (_contador == 0) {
        gerarTabuleiro();
      }
      if (_contador % 2 == 0) {
        setElementoCoordenada(
          getInput(jogadores[0]),
          _contador,
        );
      } else {
        setElementoCoordenada(
          player.getTheBestMove(),
          _contador,
        );
      }

      verificaVencedor(
        _contador % 2 == 0 ? jogadores[0] : jogadores[1],
      );
      _contador++;
      print("\x1B[2J\x1B[0;0H");
      gerarTabuleiro();
    }
  }

  void jogarContraHumano({
    required List<Jogador> jogadores,
  }) {
    while (true) {
      if (_contador == 0) {
        gerarTabuleiro();
      }
      setElementoCoordenada(
        getInput(_contador % 2 == 0 ? jogadores[0] : jogadores[1]),
        _contador,
      );
      verificaVencedor(
        _contador % 2 == 0 ? jogadores[0] : jogadores[1],
      );
      _contador++;
      print("\x1B[2J\x1B[0;0H");
      gerarTabuleiro();
    }
  }
}
