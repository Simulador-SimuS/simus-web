;=======================================================
; ROTINA: Converter valor 0-255 em string e imprimir
; 
; Entrada: AC = valor (0-255)
; Saída: Imprime no banner via OUT 02
;
; Exemplo de uso:
;   LDA  #42
;   JSR  PRINT_DEC
;   ; Imprime: "42"
;=======================================================

ORG 0x0000h

MAIN:
    ; Teste 1: Imprimir 42
    LDA  #42
    JSR  PRINT_DEC
    
    ; Teste 2: Imprimir 255
    LDA  #255
    JSR  PRINT_DEC
    
    ; Teste 3: Imprimir 0
    LDA  #0
    JSR  PRINT_DEC
    
    ; Teste 4: Imprimir 7
    LDA  #7
    JSR  PRINT_DEC
    
    HLT

;=======================================================
; PRINT_DEC: Imprime número decimal (0-255)
; 
; Entrada: AC = número
; Modifica: Memória em NUM_TEMP, STR_BUFFER
;=======================================================

PRINT_DEC:
    ; Armazena número
    STA  NUM_TEMP
    
    ; Testa se é 0
    LDA  NUM_TEMP
    SUB  #0
    JZ   PRINT_ZERO
    
    ; Converte para string
    JSR  BINARY_TO_STRING
    
    ; Imprime a string
    JSR  PRINT_STRING
    
    RET

;=======================================================
; PRINT_ZERO: Caso especial para zero
;=======================================================

PRINT_ZERO:
    ; Armazena "0" em buffer
    LDA  #30h
    STA  STR_BUFFER
    
    LDA  #0
    STA  STR_BUFFER + 1  ; NULL terminator
    
    ; Imprime
    JSR  PRINT_STRING
    
    RET

;=======================================================
; BINARY_TO_STRING: Converte AC para string decimal
; 
; Entrada: NUM_TEMP = número (1-255)
; Saída: STR_BUFFER = string terminada com 0
;   
;
; Estratégia:
; 1. Extrair centena (0-2)
; 2. Extrair dezena (0-9)
; 3. Extrair unidade (0-9)
;=======================================================

BINARY_TO_STRING: 
    LDA STR_ADDR    ; RESETA ENDEREÇO
    STA STR_PTR       
    LDA STR_ADDR+1
    STA STR_ADDR+1
    ; ===== CENTENA (0-2) =====
    ; Testa se >= 200
    LDA  NUM_TEMP
    SUB  #200
    JC   CHECK_100
    
    ; Encontrou 200+
    ; Número -= 200
    STA  NUM_TEMP
    LDA  #32h
    STA  @STR_PTR
    LDA  STR_PTR
    ADD  #1
    STA  STR_PTR
    JMP  CHECK_100_SKIP

CHECK_100:
    ; Testa se >= 100
    LDA  NUM_TEMP
    SUB  #100
    JC   SKIP_100
    
    ; Encontrou 100+
    STA  NUM_TEMP
    LDA  #31h
    STA  @STR_PTR
    LDA  STR_PTR
    ADD  #1
    STA  STR_PTR

SKIP_100:
CHECK_100_SKIP:
    
    ; ===== DEZENA (0-9) =====
    ; Loop para contar dezenas
    LDA  #0
    STA  DIGIT_TENS
    
LOOP_TENS:
    ; Testa se NUM_TEMP >= 10
    LDA  NUM_TEMP
    SUB  #10
    JN   DONE_TENS
    
    ; Encontrou uma dezena
    STA  NUM_TEMP
    LDA  DIGIT_TENS
    ADD  #1
    STA  DIGIT_TENS
    
    JMP  LOOP_TENS

DONE_TENS:
    ; Armazena dezena se > 0 ou já temos centena
    LDA  DIGIT_TENS
    SUB  #0
    JZ   SKIP_TENS
    
    ; Temos dezena: '0' + DIGIT_TENS
    LDA  DIGIT_TENS
    ADD  #30h      ; Converte para ASCII
    STA  @STR_PTR
    LDA  STR_PTR
    ADD  #1
    STA  STR_PTR

SKIP_TENS:
    ; ===== UNIDADE =====
    ; NUM_TEMP contém o resto (0-9)
    LDA  NUM_TEMP
    ADD  #30h       ; Converte para ASCII
    
    ; Calcula índice: STR_BUFFER + STR_IDX
    STA  DIGIT_UNIT_ASCII
    
    ; Armazena unidade
    LDA  DIGIT_UNIT_ASCII
    STA  @STR_PTR
    
    ; Incrementa índice
    LDA  STR_PTR
    ADD  #1
    STA  STR_PTR
    
    ; Adiciona NULL terminator
    LDA  #0
    STA  @STR_PTR
    
    RET

;=======================================================
; PRINT_STRING: Imprime string terminada com NULL
; 
; Entrada: STR_BUFFER = string (terminada com 0)
; Saída: Imprime via OUT 02
;=======================================================

PRINT_STRING:
    LDA STR_ADDR   ; RESETA ENDEREÇO
    STA STR_PTR
    LDA STR_ADDR+1
    STA STR_PTR+1
    
PRINT_LOOP:
    ; Lê caractere atual
    ; Endereço = STR_PRINT_PTR
    LDA  @STR_PTR
    
    ; Testa se é NULL (fim da string)
    SUB  #0
    JZ   PRINT_END
    
    ; Escreve caractere via OUT 02
    LDA  @STR_PTR
    OUT  02         ; OUT 02 = TRAP 2 (escrever caractere)
    
    ; Próximo caractere
    LDA  STR_PTR
    ADD  #1
    STA  STR_PTR
    
    JMP  PRINT_LOOP

PRINT_END:
    
    RET

;=======================================================
; DADOS - 16 bytes: espaço para número até 3 dígitos
;=======================================================

ORG 0x0200h

NUM_TEMP:           DB   0
DIGIT_TENS:         DB   0
DIGIT_UNIT_ASCII:   DB   0
ZERO                EQU  30h

STR_ADDR:           DW   STR_BUFFER
STR_BUFFER:         DS   4      ; "255" + NULL
STR_PTR:            DW   STR_BUFFER

    END MAIN
