; Conta pares e impares; mostra ambos no banner.
; ROTINA consome o argumento de 16 bits e preserva a pilha.
; Recarregue o programa antes de repetir a contagem.
ORG 0x200

; Declaração das variáveis do programa principal
TAM_VETOR:   	DB	10  
END_VETOR:   	DW	VETOR
PARES:       	DB	0
IMPARES:     	DB	0
VETOR:       	DB 	1,2,3,4,5,6,7,8,9,10
CONT:        	DB  	0
STR_PARES:   	STR 	"Pares:"
             	DB 	0
STR_IMPARES: 	STR 	" Impares:"
             	DB 	0

PT_PARES:   DW STR_PARES
PT_IMPARES: DW STR_IMPARES

ORG 0
        OUT CLEARB

; Faz a leitura de um elemento do vetor e incrementa o contador
INICIO:
        LDA     CONT
        SUB     TAM_VETOR
        JZ      FIM
	LDA  	CONT
        ADD  	#1
        STA  	CONT
        LDA 	@END_VETOR
            
; Testa se é par (bit 0=0)
        AND     #1
        JNZ     EHIMPAR

; Se for par, faz pares++
EHPAR:
        LDA     #1
        ADD     PARES
        STA     PARES
        JMP     TESTE

; Se for impar, faz impares++
EHIMPAR:
        LDA     #1
        ADD     IMPARES
        STA     IMPARES

; Incrementa o apontador e verifica se o loop acabou
TESTE:   
        LDA     END_VETOR
        ADD     #1
        STA     END_VETOR
        LDA     END_VETOR+1
        ADC     #0
        STA     END_VETOR+1
        LDA     TAM_VETOR
        SUB     CONT           
        JNZ     INICIO

; Coloca o endereço da string na pilha e chama a rotina de impressão
FIM:    LDA     PT_PARES+1  
        PUSH
        LDA     PT_PARES
        PUSH
        JSR     ROTINA

; Imprime o contador em decimal (0-255)
        LDA     PARES
        JSR     DECIMAL

; Coloca o endereço da string na pilha e chama a rotina de impressão
        LDA     PT_IMPARES+1
        PUSH
        LDA     PT_IMPARES
        PUSH
        JSR     ROTINA

; Imprime o contador em decimal (0-255)
        LDA     IMPARES
        JSR     DECIMAL
        HLT
END     0        
;------------------------------------------------------
; Rotina para impressão de uma string no banner
; Declaração das variáveis da rotina

ORG 1000
RA:     DW 0      ; Endereco de retorno, nao o valor de SP
PTR:  	DW     	0	; Ponteiro com o endereço da string a ser impressa


; Constantes de hardware
CLEARB  EQU 3
BANNER  EQU 2
;------------------------------------------------------

ROTINA:
        POP                 ; Retira e salva o retorno de JSR
        STA     RA
        POP
        STA     RA+1
        POP                 ; Consome os dois bytes do argumento
        STA     PTR
        POP
        STA     PTR+1
LOOP:
        LDA     @PTR
        OR      #0
        JZ      RETORNA
        OUT     BANNER
        LDA     PTR
        ADD     #1
        STA     PTR
        LDA     PTR+1
        ADC     #0
        STA     PTR+1
        JMP     LOOP
RETORNA:
        LDA     RA+1        ; Reempilha somente o retorno
        PUSH
        LDA     RA
        PUSH
        RET                 ; SP volta ao valor anterior aos argumentos

; Imprime AC (0-255) em decimal, sem zeros a esquerda.
; JSR/RET balanceados; nao recebe argumentos pela pilha.
DECIMAL:
        STA     NUMERO
        LDA     #0
        STA     CENTENAS
        STA     DEZENAS
CENTENA:
        LDA     NUMERO
        SUB     #100
        JC      DEZENA
        STA     NUMERO
        LDA     CENTENAS
        ADD     #1
        STA     CENTENAS
        JMP     CENTENA
DEZENA:
        LDA     NUMERO
        SUB     #10
        JC      MOSTRA_NUMERO
        STA     NUMERO
        LDA     DEZENAS
        ADD     #1
        STA     DEZENAS
        JMP     DEZENA
MOSTRA_NUMERO:
        LDA     CENTENAS
        JZ      TESTA_DEZENA
        ADD     #48
        OUT     BANNER
        JMP     MOSTRA_DEZENA
TESTA_DEZENA:
        LDA     DEZENAS
        JZ      UNIDADE
MOSTRA_DEZENA:
        LDA     DEZENAS
        ADD     #48
        OUT     BANNER
UNIDADE:
        LDA     NUMERO
        ADD     #48
        OUT     BANNER
        RET
NUMERO:    DB 0
CENTENAS:  DB 0
DEZENAS:   DB 0
