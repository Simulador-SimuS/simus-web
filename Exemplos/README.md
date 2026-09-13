# Exemplos para SimuS-Web

Nos exemplos com entrada pelo painel, confirme cada valor com **Enter** e observe a base selecionada. Para os exemplos gráficos, abra a janela **Video**. Recarregue o programa antes de uma nova execução para restaurar seus dados iniciais.

| Programa | Descrição |
|---|---|
| `banner_escreve_cadeia.asm` | Percorre uma cadeia de caracteres e a escreve no banner e no terminal usando endereçamento indireto. |
| `busca_linear.asm` | Procura um valor no vetor e mostra o índice da primeira ocorrência; mostra `FF` se não encontrar. |
| `compara_soma.asm` | Lê dois números e uma opção para mostrar o maior, o menor, a soma ou a diferença, com aritmética de 8 bits. |
| `console_imprime_alfabeto.asm` | Lê um caractere no terminal e imprime 26 caracteres consecutivos; com `A`, escreve o alfabeto maiúsculo. |
| `console_le_e_ecoa.asm` | Lê um caractere e imprime uma sequência de 26 caracteres a partir dele, seguida de quebra de linha. |
| `console_le_string.asm` | Lê e ecoa linhas de até 127 bytes, precedidas de `>`, usando um buffer de 128 bytes. |
| `conta_pares_impares.asm` | Conta os elementos pares e ímpares do vetor e mostra a contagem escolhida pelo usuário. |
| `conta_pares_impares_vetor.asm` | Conta os elementos pares e ímpares e apresenta os dois totais na mesma linha do banner. |
| `conta_uns_16.asm` | Conta os bits iguais a 1 em uma palavra de 16 bits, passando seu endereço pela pilha. |
| `conta_uns_32.asm` | Conta os bits iguais a 1 nos quatro bytes de uma palavra de 32 bits. |
| `contagem_regressiva.asm` | Lê um valor de 0 a 255, exibe a contagem regressiva e termina ao mostrar zero. |
| `contagem_regressiva_decimal.asm` | Conta de um valor entre 0 e 99 até zero, com saída em BCD para leitura decimal no visor hexadecimal. |
| `contagem_regressiva_manual.asm` | Decrementa o valor inicial a cada confirmação no painel e termina ao mostrar zero. |
| `converte_binario.asm` | Converte um valor de 0 a 99 em dois dígitos decimais no banner; valores maiores produzem `?`. |
| `converte_hexa_para_decimal.asm` | Converte valores de 0 a 99 para BCD no visor; valores maiores mostram `FF` e exigem nova entrada. |
| `copia_cadeia.asm` | Copia uma cadeia de bytes para outra área de memória, incluindo o terminador zero. |
| `fatorial.asm` | Calcula o fatorial do número informado; entradas de 0 a 5 produzem resultados exatos em 8 bits. |
| `fibonacci.asm` | Demonstra recursão e uso da pilha calculando o décimo termo da sequência de Fibonacci, igual a 55. |
| `imprime_alfabeto.asm` | Imprime no terminal 26 caracteres consecutivos a partir do caractere informado pelo usuário. |
| `imprime_vetor.asm` | Percorre um vetor por ponteiro e apresenta seus elementos, um de cada vez, no visor. |
| `maximo_vetor.asm` | Encontra o maior elemento e seu primeiro índice; a opção 0 compara sem sinal e a opção 1, com sinal. |
| `mdc.asm` | Calcula o máximo divisor comum de dois números de 0 a 255 pelo algoritmo de Euclides. |
| `memset.asm` | Preenche uma área de memória com um byte, recebendo endereço, quantidade e valor pela pilha. |
| `menor_vetor.asm` | Encontra o menor elemento e calcula a soma dos valores do vetor de demonstração. |
| `ordena_vetor.asm` | Ordena em ordem crescente o vetor de demonstração, usando ponteiros para comparar e trocar elementos. |
| `ordena_vetor_2.asm` | Ordena o vetor em ordem crescente conforme a opção: 0 para bytes sem sinal ou 1 para bytes com sinal. |
| `par_impar.asm` | Identifica a paridade do valor informado e registra o resultado nas variáveis `PARES` e `IMPARES`. |
| `parametros.asm` | Demonstra a passagem de um ponteiro e de um tamanho pela pilha, com retirada dos argumentos pela subrotina. |
| `rotina_banner.asm` | Usa uma subrotina para imprimir duas cadeias no banner, limpando a mensagem anterior a cada chamada. |
| `soma_8bits.asm` | Soma dois valores de 8 bits usando uma subrotina com parâmetros e resultado passados pela pilha. |
| `soma_b_c.asm` | Soma dois valores armazenados na memória, salva o resultado e o apresenta no visor. |
| `soma_chaves.asm` | Lê dois valores do painel e mostra sua soma de 8 bits após uma terceira confirmação. |
| `soma_console.asm` | Soma dois valores, verifica o resultado esperado e imprime uma mensagem no terminal. |
| `soma_vetor.asm` | Percorre o vetor com um ponteiro, acumula seus elementos e mostra a soma no visor. |
| `soma_vetor_dec.asm` | Soma o vetor e apresenta as somas parciais e o total em BCD no visor hexadecimal. |
| `video_circulos_concentricos.asm` | Desenha oito círculos concêntricos coloridos, com raios de 3 a 31 pixels, sobre fundo azul escuro. |
| `video_paleta_cores.asm` | Preenche a tela com as 256 cores disponíveis, distribuídas em uma grade de 16 × 16 blocos. |
| `video_teste_manual.asm` | Reproduz o teste do manual: retângulo vermelho, reta verde e círculo amarelo sobre fundo azul. |
---


**Observações:** resultados aritméticos de 8 bits podem sofrer estouro. `menor_vetor.asm`, `ordena_vetor.asm` e `soma_vetor_dec.asm` foram validados para os dados de demonstração; para ordenar com escolha explícita de sinal, use `ordena_vetor_2.asm`. Em cópias e preenchimentos, reserve espaço suficiente no destino. Nos exemplos de vídeo, a imagem permanece visível após o término.
