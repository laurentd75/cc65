;
; 2020-07-14, Groepaz
;
; unsigned char cpeekrevers (void);
;
; get inverse flag from current position, do NOT advance cursor

        .export         _cpeekrevers

        .include        "pce.inc"
        .include        "extzp.inc"

_cpeekrevers:
        st0     #VDC_MARR       ; Memory-Address Read
        ldy     SCREEN_PTR
        ldx     SCREEN_PTR+1
        sty     a:VDC_DATA_LO
        stx     a:VDC_DATA_HI

        st0     #VDC_VRR        ; VRAM Read Register

        lda     a:VDC_DATA_LO   ; character (bit 7 is revers bit)
        and     #$80            ; get reverse bit
        asl     a               ; reverse bit to carry, A=0
        tax                     ; ldx #>$0000
        rol     a               ; reverse bit from carry
        rts
