;---------------------------------------------------
; Video: paleta completa de 256 cores RRRGGGBB
; SimuS 0981-video - tela de 128 x 64 pixels
; 16 colunas x 16 linhas; blocos de 8 x 4 pixels.
; As cores vao de 0 a 255, da esquerda para a direita.
; Execute ate HLT e abra a janela Video se necessario.
; OUT 0 recebe 0 no sucesso, ou o codigo de erro da TRAP.
; Recompile/recarregue antes de executar novamente.
;---------------------------------------------------
ORG 0
MAIN:
        LDA  #20
        TRAP VIDEO_CONFIG
        OR   #0             ; TRAP nao atualiza as flags
        JNZ  ERRO

DESENHA:
        LDA  #24            ; Retangulo preenchido
        TRAP BLOCO
        OR   #0
        JNZ  ERRO

        LDA  BLOCO+4        ; Proxima cor
        ADD  #1
        STA  BLOCO+4
        JZ   FIM            ; 255 + 1 = 0: todas as cores desenhadas

        LDA  BLOCO          ; Proxima coluna: x += 8
        ADD  #8
        STA  BLOCO
        SUB  #128
        JNZ  DESENHA

        LDA  #0             ; Nova linha: x = 0, y += 4
        STA  BLOCO
        LDA  BLOCO+1
        ADD  #4
        STA  BLOCO+1
        JMP  DESENHA

FIM:    LDA  #0
ERRO:   OUT  0              ; 0 = sucesso; outro valor = erro
        HLT

ORG 0x200
VIDEO_CONFIG: DW  16384     ; Framebuffer em 0x4000, longe do programa
;                x, y, largura, altura, cor, preenchido
BLOCO:        DB  0, 0, 8, 4, 0, 1
END MAIN
