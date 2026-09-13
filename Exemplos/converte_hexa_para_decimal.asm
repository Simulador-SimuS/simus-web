; --------------------------------------------------------
; Programa: Converte números hexadecimais para decimal (entre 00 e 99) 
; Autor: Gabriel P. Silva
; Data: 2016
;----------------------------------------------------------
; Aceita valores de 0 a 99 decimal (00 a 63 hexadecimal).
; Confirme no painel. Valores maiores exibem FF e aguardam
; outra entrada. Use o visor hexadecimal para ler o BCD.
ORG  100
VALOR:   DS   1    ;
MOSTRA:  DS   1    ;

ORG  0
MAIN:    IN   1      ; Aguarda confirmação da entrada
         AND  #1
         JZ   MAIN
         IN   0      ; ACC = Chaves
         STA  VALOR  ;
         STA  MOSTRA ;
         SUB  #100   ; Compara como byte sem sinal
         JNC  INVALIDO
         LDA  VALOR
LACO:    SUB  #10    ; 
         JC   SAIDA  ; Houve empréstimo: VALOR era menor que 10
         STA  VALOR  ;
         LDA  #6     ;
         ADD  MOSTRA ;
         STA  MOSTRA ;
         LDA  VALOR  ;
         JMP  LACO   ;
SAIDA:   LDA  MOSTRA ;
         OUT   0     ;
         HLT         ;
INVALIDO:
         LDA  #0FFh  ; Entrada fora de 0-99
         OUT  0
         JMP  MAIN
         END  MAIN
