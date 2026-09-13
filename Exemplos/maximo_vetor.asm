; Maior valor e indice da primeira ocorrencia.
; Autores originais: Gabriel P. Silva e Antonio Borges, 12/08/2023.
; Opcao no painel: 0 = sem sinal (0..255), 1 = com sinal (-128..127).
; Outra opcao mostra FF e aguarda nova entrada.
; Resultado em MAX, MAXIND e visor (byte original, na base selecionada).
; Vetor vazio: MAX=FF, MAXIND=FF, visor FF.
; XOR 128 normaliza a ordem com sinal antes de comparar por SUB/JC.
ORG 0
INICIO:
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
        STA IND
        STA MAXIND
        LDA MODO
        JZ PREPARA
        LDA #128
        STA MASCARA
PREPARA:
        LDA BASE
        STA PONTEIRO
        LDA BASE+1
        STA PONTEIRO+1
        LDA TAM
        JZ VAZIO
        LDA @PONTEIRO
        STA MAX
LACO:   LDA IND
        ADD #1
        STA IND
        SUB TAM
        JNC FIM
        LDA PONTEIRO
        ADD #1
        STA PONTEIRO
        LDA PONTEIRO+1
        ADC #0
        STA PONTEIRO+1
        LDA MAX
        XOR MASCARA
        STA COMPARADO
        LDA @PONTEIRO
        XOR MASCARA
        SUB COMPARADO
        JC LACO
        JZ LACO
        LDA @PONTEIRO
        STA MAX
        LDA IND
        STA MAXIND
        JMP LACO
VAZIO:  LDA #255
        STA MAX
        STA MAXIND
FIM:    LDA MAX
        OUT 0
        HLT
ORG 0x400
TAM: DB 10
IND: DB 0
MAXIND: DB 0
MAX: DB 0
PONTEIRO: DW VETOR
BASE: DW VETOR
MODO: DB 0
MASCARA: DB 0
COMPARADO: DB 0
VETOR: DB 11,27,31,82,23,80,127,0FFh,47,6
MENSAGEM: STR "Comparacao: 0=sem sinal, 1=com sinal. Informe no painel de entrada."
          DB 13,10,0
END INICIO
