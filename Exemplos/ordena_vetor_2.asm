; Ordena em ordem crescente. Autor original: Thales de Freitas, 02/05/2016.
; Opcao no painel: 0 = sem sinal (0..255), 1 = com sinal (-128..127).
; Outra opcao mostra FF e aguarda nova entrada.
; XOR 128 transforma a ordem com sinal em ordem sem sinal.
; SUB/JC compara sem depender de overflow. Resultado na memoria X.
; Vetor vazio nao e acessado. Ponteiros completos de 16 bits.
ORG 0
MAIN:
        LDA #4
        TRAP MENSAGEM
ESPERA: IN 1
        AND #1
        JZ ESPERA
        IN 0
        STA MODO
        SUB #2
        JC VALIDA
        LDA #255
        OUT 0
        JMP ESPERA
VALIDA: LDA #0
        STA MASCARA
        STA I
        LDA MODO
        JZ EXTERNO
        LDA #128
        STA MASCARA
EXTERNO:
        LDA I
        SUB TAM
        JNC FIM
        LDA I
        ADD #1
        STA J
        LDA BASE
        ADD I
        STA PT_I
        LDA BASE+1
        ADC #0
        STA PT_I+1
INTERNO:
        LDA J
        SUB TAM
        JNC PROXIMO_I
        LDA BASE
        ADD J
        STA PT_J
        LDA BASE+1
        ADC #0
        STA PT_J+1
        LDA @PT_J
        XOR MASCARA
        STA COMPARADO
        LDA @PT_I
        XOR MASCARA
        SUB COMPARADO
        JC PROXIMO_J
        JZ PROXIMO_J
        LDA @PT_I
        STA TMP
        LDA @PT_J
        STA @PT_I
        LDA TMP
        STA @PT_J
PROXIMO_J:
        LDA J
        ADD #1
        STA J
        JMP INTERNO
PROXIMO_I:
        LDA I
        ADD #1
        STA I
        JMP EXTERNO
FIM:   HLT
ORG 0x400
PT_I: DW X
PT_J: DW X
BASE: DW X
I: DB 0
J: DB 0
TMP: DB 0
COMPARADO: DB 0
MODO: DB 0
MASCARA: DB 0
TAM: DB 10
X: DB 6,2,20,2,10,5,60,4,8,0FFh
MENSAGEM: STR "Comparacao: 0=sem sinal, 1=com sinal. Informe no painel de entrada."
          DB 13,10,0
END MAIN
