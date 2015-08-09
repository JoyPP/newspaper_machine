//
//-------------------------------------------------------------------------------------------------
// This is an example to show you how to write simple Verilog HDL program.
// Copy right belongs to SCSE of BUAA, 2013
//-------------------------------------------------------------------------------------------------
// Title        : Newspaper vending machine
// Author       : Gao Xiaopeng (gxp@buaa.edu.cn)
//-------------------------------------------------------------------------------------------------
// Description  : 
// Note         : 
//-------------------------------------------------------------------------------------------------

module vend_ctrl( coin, clock, reset, newspaper ) ;
    input   [1:0]   coin ;                              // input two bits coin
    input           clock ;                             // system clock
    input           reset ;                             // synchronous reset
    output          newspaper ;                         // output newspaper
    wire            newspaper ;                         
    
    // variables declaration
    reg     [1:0]   fsm_state ;                         // define fsm_state as a reg to note coins input
    
    // codes of state mechine
    parameter   S0  = 2'b00 ;                           // define state S0 as two bits binary 00
    parameter   S5  = 2'b01 ;                           // define state S5 as two bits binary 01
    parameter   S10 = 2'b10 ;                           // define state S10 as two bits binary 10
    parameter   S15 = 2'b11 ;                           // define state S15 as two bits binary 11
    // codes of coin input
    parameter   COIN_0  = 2'b00 ;                       // define constant COIN_0 as two bits binary 00,get 0-cent
    parameter   COIN_5  = 2'b01 ;                       // define constant COIN_5 as two bits binary 01,get a d-cent coin
    parameter   COIN_10 = 2'b10 ;                       // define constant COIN_10 as two bits binary 10,get a 10-cent coin

    // 
    assign  newspaper = (fsm_state == S15) ;            // if fsm_state == S15 ,newspaper out
    
    //
    always  @( posedge clock )
        if ( reset )
            fsm_state <= S0 ;                                           // reset == 1 , fsm_state <=S0
        else
            case ( fsm_state ) 
                S0  :   if      ( coin == COIN_5 )  fsm_state <= S5 ;   // S0 --> S5 : get a 5-cent coin
                        else if ( coin == COIN_10 ) fsm_state <= S10 ;  // S0 --> S10: get a 10-cent coin
                S5  :   if      ( coin == COIN_5 )   fsm_state <= S10 ; // S5 --> S10: get a 5-cent coin
                        else if ( coin == COIN_10 )  fsm_state <= S15 ; // S5 --> S15: get a 10-cent coin
                S10 :   if      ( coin == COIN_5 )  fsm_state <= S15 ;  // S10 --> S15: get a 5-cent coin
                        else if ( coin == COIN_10 ) fsm_state <= S15 ;  // S10 --> S15: get a 10-cent coin
                S15 :   fsm_state  <= S0 ;                              // if S15 , fsm_state turns to S0
                default : fsm_state <= S0 ;                             // if state!=S0 or S5 or S10 or S15, fsm_state turns to S0
            endcase

endmodule