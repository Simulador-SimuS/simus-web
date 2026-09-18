; Parabéns para você — melodia e letra progressiva no banner.
; SimuS-Web 1.0 / 1.01. Compile e use TURBO, sem breakpoints.
; O modo normal insere uma espera por instrução e altera o ritmo.
; TRAP 6 inicia o tom; TRAP 5 aguarda sua duração antes da próxima nota.
; A sincronização é aproximada, sujeita aos temporizadores do navegador.
; Cada frase substitui a anterior; a última permanece após HLT.
; Não há impressão de frequências no banner.
;
; Tabela: frequência (Hz), duração (ms), endereço do trecho de letra.
; Byte 1 no início de um trecho limpa o banner; byte 0 encerra o trecho.
; As frequências são aproximadas em Hz inteiros. Sem parâmetros na pilha.
ORG 0
INICIO:
    LDS #0xFF00
    LDA BASE
    STA PT_NOTA
    LDA BASE+1
    STA PT_NOTA+1
    LDA #27
    STA RESTANTES
    OUT 3
PROXIMA:
    JSR LER_BYTE
    STA FREQ
    JSR LER_BYTE
    STA FREQ+1
    JSR LER_BYTE
    STA DUR
    JSR LER_BYTE
    STA DUR+1
    JSR LER_BYTE
    STA PT_LETRA
    JSR LER_BYTE
    STA PT_LETRA+1
    JSR LETRA
    LDA #6
    TRAP FREQ
    LDA #5
    TRAP DUR
    LDA RESTANTES
    SUB #1
    STA RESTANTES
    JNZ PROXIMA
    HLT

; Lê um byte da tabela, avançando o ponteiro de 16 bits.
LER_BYTE:
    LDA @PT_NOTA
    STA BYTE_LIDO
    LDA PT_NOTA
    ADD #1
    STA PT_NOTA
    LDA PT_NOTA+1
    ADC #0
    STA PT_NOTA+1
    LDA BYTE_LIDO
    RET

LETRA:
    LDA @PT_LETRA
    OR #0
    JZ FIM_LETRA
    SUB #1
    JZ LIMPAR
    LDA @PT_LETRA
    OUT 2
    JMP AVANCAR_LETRA
LIMPAR:
    OUT 3
AVANCAR_LETRA:
    LDA PT_LETRA
    ADD #1
    STA PT_LETRA
    LDA PT_LETRA+1
    ADC #0
    STA PT_LETRA+1
    JMP LETRA
FIM_LETRA:
    RET

ORG 0x0200
FREQ: DW 0
DUR: DW 0
PT_NOTA: DW 0
PT_LETRA: DW 0
BYTE_LIDO: DB 0
RESTANTES: DB 0
BASE: DW NOTAS
NOTAS:
    DW 262, 375, T1
    DW 262, 125, T2
    DW 294, 500, T3
    DW 262, 500, T4
    DW 349, 500, T5
    DW 330, 1000, T6
    DW 262, 375, T7
    DW 262, 125, T8
    DW 294, 500, T9
    DW 262, 500, T10
    DW 392, 500, T11
    DW 349, 500, T12
    DW 349, 500, T13
    DW 262, 375, T14
    DW 262, 125, T15
    DW 523, 500, T16
    DW 440, 500, T17
    DW 349, 500, T18
    DW 330, 500, T19
    DW 294, 500, T20
    DW 466, 375, T21
    DW 466, 125, T22
    DW 440, 500, T23
    DW 349, 500, T24
    DW 392, 500, T25
    DW 349, 500, T26
    DW 349, 500, T27

; Trechos da letra, codificados em Latin-1 pelo montador.
T1: DB 1
    STRZ "Pa"
T2: STRZ "ra"
T3: STRZ "béns "
T4: STRZ "para "
T5: STRZ "vo"
T6: STRZ "cê,"
T7: DB 1
    STRZ "nes"
T8: STRZ "ta "
T9: STRZ "da"
T10: STRZ "ta "
T11: STRZ "que"
T12: STRZ "ri"
T13: STRZ "da,"
T14: DB 1
    STRZ "mui"
T15: STRZ "tas "
T16: STRZ "fe"
T17: STRZ "li"
T18: STRZ "ci"
T19: STRZ "da"
T20: STRZ "des,"
T21: DB 1
    STRZ "mui"
T22: STRZ "tos "
T23: STRZ "a"
T24: STRZ "nos "
T25: STRZ "de "
T26: STRZ "vi"
T27: STRZ "da."

END INICIO
