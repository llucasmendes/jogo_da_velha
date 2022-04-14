import 'dart:io';

import 'game/artificial_player.dart';
import 'models/jogador.dart';
import 'models/tabuleiro.dart';

void main() {
  var tabuleiro = Tabuleiro();
  tabuleiro.showWellcome();
  ArtificialPlayer player = ArtificialPlayer(board: tabuleiro.valores);
  late String? opcao;

  do {
    stdout.write('\n');
    stdout.write(
        '\nDigite - \x1B[32m1\x1B[0m para jogar contra o computador\nDigite - \x1B[32m2\x1B[0m para jogar contra outro jogador\n');
    stdout.write('Digite - \x1B[32m3\x1B[0m para sair\n > ');

    opcao = stdin.readLineSync();

    if (opcao == '1') {
      List<Jogador> jogadores = [
        Jogador(
          nome: 'Você',
        ),
        Jogador(
          nome: 'Computador',
        )
      ];

      tabuleiro.jogarContraMaquina(
        jogadores: jogadores,
        player: player,
      );
    } else if (opcao == '2') {
      List<Jogador> jogadores = tabuleiro.setPlayersName();

      tabuleiro.jogarContraHumano(
        jogadores: jogadores,
      );
    } else if (opcao == '3') {
      print('\n\x1B[33mObrigado por jogar!\n\x1B[0m');
      exit(0);
    } else {
      print('Opção inválida');
    }
  } while (opcao != '1' || opcao != '2' || opcao != '3');
}
