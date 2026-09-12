;---------------------------------------------------
; Programa: Contagem regressiva manual controlada
;           pelo painel de chaves
; Autor: Gabriel P. Silva
; Data: 15.09.2003
; Arquivo: contagem_regressiva_manual.asm
;---------------------------------------------------
; 1. Coloque o valor inicial nas chaves e pressione ENTER
; 2. A cada pressionamento de ENTER o visor decrementa
; 3. Ao exibir zero, termina. Entrada inicial zero termina logo.
; Aceita 0-255; o valor das confirmações seguintes é descartado.
;---------------------------------------------------
ORG 0
; --- Lê o valor inicial ---
STATUS1:
        IN   1              ; Verifica se há valor disponível
        AND  #1             ; Testa bit de status
        JZ   STATUS1        ; Aguarda
        IN   0              ; Lê o valor das chaves
        STA  X              ; Guarda em X
        OUT  0              ; Exibe no visor
        LDA  X              ; Testa a entrada inicial, inclusive zero
        JZ   FIM

; --- A cada ENTER decrementa e exibe ---
STATUS2:
        IN   1
        AND  #1
        JZ   STATUS2        ; Aguarda próximo ENTER
        IN   0              ; Consome e descarta a confirmação
        LDA  X              ; Lê o valor atual
        SUB  #1             ; Decrementa
        STA  X              ; Guarda de volta
        OUT  0              ; Exibe no visor
        LDA  X              ; Zero já foi exibido
        JZ   FIM
        JMP  STATUS2        ; Aguarda a próxima confirmação
FIM:    HLT
        END  STATUS1

ORG 100
X:      DS  1
