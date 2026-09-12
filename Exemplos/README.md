# ExemplosOk — seleção para SimuS 0981-video

Atualização: JP foi corrigido no simulador conforme o código original (N=0 e Z=0). Os 18 exemplos desta seleção foram reexecutados e mantiveram suas saídas. O manifesto preserva o hash da auditoria inicial e registra a revalidação separadamente; detalhes em `../verificacao_jp_resultados.json`. Nenhum Assembly desta pasta foi alterado.

25 exemplos: 24 provenientes de exemplos_corrigidos e soma_chaves.asm de Exemplos. As três contagens regressivas foram corrigidas em exemplos_corrigidos e copiadas para esta pasta. Os dois conta_pares_impares foram movidos de exemplos_corrigidos após a correção de JP; os 18 anteriores foram copiados.

Critério: resultado correto nos cenários auditados; entre versões elegíveis, vence a data de modificação mais recente disponível. Datas podem refletir extração do ZIP, não autoria; não há histórico de versões que permita datar melhor. Em empate, preferência por exemplos_corrigidos. Uma revisão com falha nunca substitui uma funcional.

A seleção inclui os 15 exemplos aprovados anteriormente, soma_chaves original, converte_binario (0–99, com rejeição fora da faixa) e fatorial (0–5, limite de 8 bits). Casos parcialmente funcionais ou pendentes foram mantidos fora deste primeiro conjunto e registrados em PENDENCIAS.md. Não foram corrigidos nesta etapa.

Referência exclusiva: simus-v0981-video.html, na pasta superior. Montador e CPU executados em Node; não representa teste visual da interface. Reinicie/recarregue cada exemplo para restaurar seus dados. Para valores numéricos, confira a base do painel.

| Arquivo | Origem | Uso validado / restrições |
|---|---|---|
| banner_escreve_cadeia.asm | exemplos_corrigidos/banner_escreve_cadeia.asm | Banner e terminal: Gabriel P. Silva. |
| console_imprime_alfabeto.asm | exemplos_corrigidos/console_imprime_alfabeto.asm | Digite A no terminal: imprime A–Z com CR/LF. |
| console_le_e_ecoa.asm | exemplos_corrigidos/console_le_e_ecoa.asm | Digite A: imprime 26 caracteres (A–Z); apesar do nome, não faz somente eco. |
| converte_binario.asm | exemplos_corrigidos/converte_binario.asm | Entrada decimal 0–99: escreve dois dígitos no banner. Valores 100–255 são rejeitados com ?. Painel pode estar em base hexadecimal. |
| fatorial.asm | exemplos_corrigidos/fatorial.asm | Entrada de 0 a 5 para resultado inteiro exato: 0!=1 e 5!=120. A partir de 6 ocorre estouro de 8 bits sem aviso. |
| fibonacci.asm | exemplos_corrigidos/fibonacci.asm | Exemplo fixo: F(10)=55 decimal (37 hexadecimal). |
| imprime_alfabeto.asm | exemplos_corrigidos/imprime_alfabeto.asm | Digite A no terminal: imprime A–Z com CR/LF. |
| imprime_vetor.asm | exemplos_corrigidos/imprime_vetor.asm | Visor hexadecimal: 10,30,25,45,22; executar passo a passo para observar cada saída. |
| menor_vetor.asm | exemplos_corrigidos/menor_vetor.asm | Vetor fornecido: mínimo 1, depois soma 49. Comparação não generalizada para quaisquer bytes sem sinal. |
| ordena_vetor.asm | exemplos_corrigidos/ordena_vetor.asm | Vetor fornecido ordenado na memória: 2,2,4,5,6,8,10,20,60,65. Comparação não generalizada para quaisquer bytes. |
| par_impar.asm | exemplos_corrigidos/par_impar.asm | Entrada no painel; resultado em PARES/IMPARES na memória. Testados 0,1 e 5. |
| rotina_banner.asm | exemplos_corrigidos/rotina_banner.asm | Imprime duas cadeias, limpando o banner entre elas. Banner final: Esta e outra cadeia. |
| soma_8bits.asm | exemplos_corrigidos/soma_8bits.asm | 2+5=7, com passagem de parâmetros pela pilha. |
| soma_b_c.asm | exemplos_corrigidos/soma_b_c.asm | 10+5=15 decimal (0F hexadecimal). |
| soma_chaves.asm | Exemplos/soma_chaves.asm | Original funcional: forneça dois valores e uma terceira confirmação. 5+3=8; soma em 8 bits. |
| soma_console.asm | exemplos_corrigidos/soma_console.asm | C=7; terminal: A soma deu certo! |
| soma_vetor.asm | exemplos_corrigidos/soma_vetor.asm | Soma do vetor fornecido: 45 decimal (2D hexadecimal). |
| soma_vetor_dec.asm | exemplos_corrigidos/soma_vetor_dec.asm | Soma 45 exibida em BCD como 45 no visor hexadecimal. Validado para o vetor fornecido, sem alteração de tamanho/endereço. |

As 18 cópias tiveram SHA-256 comparado à origem e execução comparada integralmente com a origem. Todas montam sem sobreposição e chegam a HLT. Faixas 0–99 do conversor e 0–5 do fatorial revalidadas nas cópias. Proveniência, datas, hashes e resultados estão em manifesto.json. As duas pastas de origem permaneceram intactas.

## Incluídos após a correção de JP

- `conta_pares_impares.asm`: JP corrigido: 9 pares/5 ímpares, 14 iterações. Opção 0 mostra pares; 1 mostra ímpares. Deixa quatro bytes de parâmetros na pilha; recarregar antes de repetir.
- `conta_pares_impares_vetor.asm`: JP corrigido: 5 pares/5 ímpares, 10 iterações. A segunda mensagem substitui a primeira no banner. Deixa quatro bytes de parâmetros na pilha; recarregar antes de repetir.

Os dois arquivos foram executados novamente no destino com opções 0 e 1; contadores e término conferidos.

## Contagens regressivas corrigidas

- `contagem_regressiva.asm`: Entrada 0–255: exibe N até 0 e termina; zero inicial exibe somente 0. Saída hexadecimal.
- `contagem_regressiva_decimal.asm`: Entrada 0–99: conta até 0 em BCD e termina. Visor hexadecimal; 99 decimal = 63 hexadecimal na entrada. Valor acima de 99 mostra FF e aguarda outra entrada.
- `contagem_regressiva_manual.asm`: Entrada 0–255: um decremento por confirmação, exibe zero e termina. Zero inicial termina imediatamente. Valores das confirmações seguintes são descartados.

Correções no controle de término, incluindo entrada zero; comparação sem sinal e validação da entrada decimal. Teste reproduzível na pasta superior: `node testar_contagens_corrigidas.cjs ExemplosOk`. Foram 773 cenários por pasta, cobrindo todos os 256 valores de entrada nas três variantes, ausência de entrada, rejeições consecutivas e confirmações manuais espaçadas.

## Contagem de bits corrigida

- `conta_uns_16.asm`: 0x55AA → 8; ORG/EQU usam prefixo 0x para evitar o erro de interpretação do sufixo H no montador.
- `conta_uns_32.asm`: 0x550155AA → 13 (0D hexadecimal); código, dados e pilha separados, ponteiro de entrada completo e preservado.

Ambos retornam o total em RESULT e no visor, preservam a palavra e restauram SP=0x300. Validados com bytes 0–255 em cada posição, padrões combinados, transições de página e execução repetida sem recarregar. Reprodução na pasta superior: `node testar_conta_uns.cjs ExemplosOk`.
