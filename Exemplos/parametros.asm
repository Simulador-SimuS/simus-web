;--------------------------------------------------
; Programa: Passagem de parametros
; Autor: Gabriel P. Silva e Antonio Borges
; Data: 12/08/2023
; Arquivo: parametros.asm
;--------------------------------------------------
ORG 0
; Declaração das variáveis do programa principal
VETOR:    DB 10, 11, 12, 15, 16
PONTEIRO: DW VETOR
TAMANHO:  DB 5 

INICIO:
    LDA  TAMANHO
    PUSH
    LDA  PONTEIRO+1
    PUSH
    LDA  PONTEIRO
    PUSH
    JSR  ROTINA
    HLT

; ROTINA recebe ponteiro (16 bits) e tamanho (8 bits).
; Consome os tres bytes de argumentos e restaura somente o retorno.
ORG 100
; Declaração das variáveis da rotina
RA:   DS 2    ; Endereco de retorno de JSR
PTR:  DS 2
VAL:  DS 1
TAM:  DS 1
ROTINA:
; Salva argumentos
    POP         ; Salva retorno, byte baixo primeiro
    STA  RA
    POP
    STA  RA+1
    POP         ; Retira o primeiro byte do primeiro parâmetro
    STA  PTR    ; Salva na parte baixa do ponteiro local
    POP         ; Retira o segundo byte do primeiro parâmetro
    STA  PTR+1  ; Salva na parte alta do ponteiro local
    POP         ; Retira o segundo parâmetro da pilha
    STA  TAM    ; Salva na variável local de tamanho
    LDA  @PTR   ; VAL = *PTR
    STA  VAL    ;
                ; Faz outras coisas
                ;
    LDA  RA+1   ; Reempilha somente o retorno, sem os argumentos
    PUSH
    LDA  RA
    PUSH
    LDA  VAL    ; Mantem no acumulador o valor lido, como no exemplo original
    RET         ; Retorna da sub-rotina
    END INICIO  
