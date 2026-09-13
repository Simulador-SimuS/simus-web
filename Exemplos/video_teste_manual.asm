; Exemplo da secao 9.4 do manual_simus.md.
; Configura video, limpa, desenha retangulo, reta e circulo.
; Execute ate HLT na 0981-video; abra a janela Video se necessario.
; O Assembly abaixo foi copiado integralmente do manual.
ORG 0

MAIN:
    LDA #20
    TRAP VIDEO_CONFIG
    OR #0
    JNZ ERRO
    LDA #21
    TRAP LIMPAR
    LDA #24
    TRAP RETANGULO
    LDA #23
    TRAP RETA
    LDA #25
    TRAP CIRCULO
    HLT
ERRO:
    HLT

VIDEO_CONFIG:
    DW VIDEO_BASE
LIMPAR:
    DB 3              ; azul
RETANGULO:
    DB 48, 16, 32, 32, 224, 1
RETA:
    DB 0, 63, 127, 0, 28
CIRCULO:
    DB 64, 32, 18, 252, 0

VIDEO_BASE EQU 16384 ; 0x4000

END MAIN
