;---------------------------------------------------
; Video: oito circulos concentricos coloridos
; SimuS 0981-video - tela de 128 x 64 pixels
; Centro (64,32); raios 3,7,11,15,19,23,27,31.
; Contornos coloridos sobre fundo azul escuro.
; Todos os circulos cabem na tela, sem recorte.
; Altere CORES para experimentar a codificacao RRRGGGBB.
; Execute ate HLT e abra a janela Video se necessario.
; OUT 0 recebe 0 no sucesso, ou o codigo de erro da TRAP.
; Recompile/recarregue antes de executar novamente.
;---------------------------------------------------
ORG 0
MAIN:
        LDA  #20
        TRAP VIDEO_CONFIG
        OR   #0
        JNZ  ERRO
        LDA  #21            ; Limpa o fundo
        TRAP FUNDO
        OR   #0
        JNZ  ERRO

DESENHA:
        LDA  @PT_COR
        STA  CIRCULO+3
        LDA  #25
        TRAP CIRCULO
        OR   #0
        JNZ  ERRO

        LDA  RESTANTES
        SUB  #1
        STA  RESTANTES
        JZ   FIM

        LDA  CIRCULO+2      ; Raio aumenta quatro pixels
        ADD  #4
        STA  CIRCULO+2

        LDA  PT_COR         ; Avanca ponteiro completo de 16 bits
        ADD  #1
        STA  PT_COR
        LDA  PT_COR+1
        ADC  #0
        STA  PT_COR+1
        JMP  DESENHA

FIM:    LDA  #0
ERRO:   OUT  0
        HLT

ORG 0x200
VIDEO_CONFIG: DW 16384      ; Framebuffer: 0x4000 a 0x5FFF
FUNDO:        DB 1          ; Azul escuro
;                cx, cy, raio, cor, preenchido (0 = contorno)
CIRCULO:      DB 64, 32, 3, 255, 0
RESTANTES:    DB 8
PT_COR:       DW CORES
; Branco, amarelo, vermelho, verde, ciano, azul, magenta, branco
CORES:        DB 255, 252, 224, 28, 31, 3, 227, 255
END MAIN
