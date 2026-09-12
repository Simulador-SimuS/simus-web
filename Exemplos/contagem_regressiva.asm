;---------------------------------------------------
; Programa: Contagem regressiva a partir de um valor
;           lido do painel de chaves
; Autor: Gabriel P. Silva
; Data: 16.09.2003
; Arquivo: contagem_regressiva.asm
;---------------------------------------------------
; Lê N (0-255), exibe N, N-1, ..., 0 e termina.
; Se N = 0, exibe somente zero. Visor hexadecimal.
;---------------------------------------------------
ORG 0
; --- Aguarda valor pronto no painel de chaves ---
STATUS1:
        IN   1              ; Verifica se há valor disponível
        AND  #1             ; Testa bit de status
        JZ   STATUS1        ; Aguarda enquanto não estiver pronto

        IN   0              ; Lê o valor N das chaves
; --- Loop: exibe e decrementa ---
LOOP:   STA  X              ; Guarda o valor atual
        OUT  0              ; Exibe no visor
        LDA  X              ; Recarrega
        JZ   FIM            ; Já exibiu zero: termina sem decrementar
        SUB  #1             ; Decrementa
        JMP  LOOP           ; Exibe o próximo valor
FIM:    HLT
        END  STATUS1

ORG 100
X:      DS  1               ; Variável auxiliar
