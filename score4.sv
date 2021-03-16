module score4 (
	input  logic clk,
	input  logic rst,

	input  logic left,
	input  logic right,
	input  logic put,
	
	output logic player,
	output logic invalid_move,
	output logic win_a,
	output logic win_b,
	output logic full_panel,

	output logic hsync,
	output logic vsync,
	output logic [3:0] red,
	output logic [3:0] green,
	output logic [3:0] blue
);



logic turn ;


//counters for coll pieces dropped 0 for none 6 is full
logic [2:0] col_0_counter;
logic [2:0] col_1_counter;
logic [2:0] col_2_counter;
logic [2:0] col_3_counter;
logic [2:0] col_4_counter;
logic [2:0] col_5_counter;
logic [2:0] col_6_counter;


logic [6:0] play;                // 7-bit wide reg vector
logic [1:0] panel [0:5][0:6];   // 2-bit wide vector 2D array with rows=6,cols=7


//each bit represents col fullnes 0-Not full 1-Full
logic [0:6] full_cols;

//assign the output about player turn to the logic for player turn 0-Player1 RED 1-Player2 GREEN
assign player=turn;

//signals that tell each column is full 

assign full_cols[0]= (col_0_counter==3'b110) ? 1 : 0 ;
assign full_cols[1]= (col_1_counter==3'b110) ? 1 : 0 ;
assign full_cols[2]= (col_2_counter==3'b110) ? 1 : 0 ;
assign full_cols[3]= (col_3_counter==3'b110) ? 1 : 0 ;
assign full_cols[4]= (col_4_counter==3'b110) ? 1 : 0 ;
assign full_cols[5]= (col_5_counter==3'b110) ? 1 : 0 ;
assign full_cols[6]= (col_6_counter==3'b110) ? 1 : 0 ;


//full panel is 1 when all colls are full 
assign full_panel= &full_cols ;


//Edge detections for inputs Left Right and Put


logic edge_reg_put;
logic edge_reg_right;
logic edge_reg_left;

always_ff @(posedge clk, posedge rst) begin
 if (rst) begin
    edge_reg_put <= 1'b0;
 end else begin
    edge_reg_put <= put;
 end
end

always_ff @(posedge clk, posedge rst) begin
 if (rst) begin
    edge_reg_right <= 1'b0;
 end else begin
    edge_reg_right <= right;
 end
end

always_ff @(posedge clk, posedge rst) begin
 if (rst) begin
    edge_reg_left <= 1'b0;
 end else begin
    edge_reg_left <= left;
 end
end

assign falling_edge_put = edge_reg_put & (~put);
assign falling_edge_left = edge_reg_left & (~left);
assign falling_edge_right = edge_reg_right & (~right);

logic[1:0] winner_hor;
logic[1:0] winner_ver;
logic[1:0] winner_diag;
logic[1:0] winner_rev_diag;

assign win_a = (winner_hor==2'b01 || winner_ver==2'b01 ||winner_diag ==2'b01 || winner_rev_diag ==2'b01)? 1: 0;
assign win_b = (winner_hor==2'b10 || winner_ver==2'b10 ||winner_diag ==2'b10 || winner_rev_diag ==2'b10) ? 1: 0;



//logic for the win check depending on turn
logic[1:0] win_value;

assign win_value =(turn==0)  ? 2'b01 : 2'b10;


always_ff@(posedge clk,posedge rst) begin
  if(rst) begin
    winner_hor<=2'b00;
    winner_ver<=2'b00;
    winner_diag<=2'b00;
    winner_rev_diag<=2'b00;
  end
  else begin
        
        //horizontal win
        
        for (int i=0; i<6; i+=1) begin
          for (int j=0; j<4; j+=1) begin
              if((panel[i][j]==win_value)&&(panel[i][j+1]==win_value)&&(panel[i][j+2]==win_value)&&(panel[i][j+3]==win_value))begin
                panel[i][j]  <=2'b11;
                panel[i][j+1]<=2'b11;
                panel[i][j+2]<=2'b11;
                panel[i][j+3]<=2'b11;
                winner_hor<=win_value;
               end
           end 
        end   
    //check for vertical win
       for (int i=0; i<7; i+=1) begin
          for (int j=0; j<3; j+=1) begin
              if((panel[j][i]==win_value)&&(panel[j+1][i]==win_value)&&(panel[j+2][i]==win_value)&&(panel[j+3][i]==win_value))begin
                panel[j][i]  <=2'b11;
                panel[j+1][i]<=2'b11;
                panel[j+2][i]<=2'b11;
                panel[j+3][i]<=2'b11;
                winner_ver<=win_value;
               end
           end 
        end 
    
      //check for diagonal win
        for (int i=0; i<4; i+=1) begin
          for (int j=5; j>2; j-=1) begin
            if ((panel[j][i]==win_value)&&(panel[j-1][i+1]==win_value)&&(panel[j-2][i+2]==win_value)&&(panel[j-3][i+3]==win_value)) begin
                panel[j][i]<=2'b11;
                panel[j-1][i+1]<=2'b11;
                panel[j-2][i+2]<=2'b11;
                panel[j-3][i+3]<=2'b11;       
                winner_diag<=win_value;
            end
          end
        end
  //------------------reverse diagonal-----------------
        for (int i=0; i<4; i+=1) begin
          for (int j=0; j<3; j+=1) begin
            if ((panel[j][i]==win_value)&&(panel[j+1][i+1]==win_value)&&(panel[j+2][i+2]==win_value)&&(panel[j+3][i+3]==win_value)) begin
                panel[j][i]<=2'b11;
                panel[j+1][i+1]<=2'b11;
                panel[j+2][i+2]<=2'b11;
                panel[j+3][i+3]<=2'b11;       
                winner_rev_diag<=win_value;
            end
         end
       end

                    

      end
             
end
  
  

   localparam
        INIT =         8'b00000001,          // Initial state
        WAIT =         8'b00000010,          // wait for user input
        MOVE_R =       8'b00000100,          // Move right 
        MOVE_L =       8'b00001000,          // Move left
        PUT =          8'b00010000,          // Put piece
        CHECK_WINNER=  8'b00100000,          // Waits for the check with new board to happen
        CHECK_WINNER2= 8'b01000000,          // If winner is found end or change player and WAIT
        END =          8'b10000000 ;         // Winner was found freeze the board

logic [7:0] state;
always_ff @(posedge clk, posedge rst) begin
  if (rst) begin
    state <= INIT;
    end else begin    
  case (state)
    INIT:
      begin
         state <= WAIT;
         turn  <=1'b0;
         invalid_move <= 1'b0;
         play <=7'b1000000;
         col_0_counter<=0;
         col_1_counter<=0;
         col_2_counter<=0;         
         col_3_counter<=0;
         col_4_counter<=0;
         col_5_counter<=0;
         col_6_counter<=0;

         for(int i = 0; i < 6; i += 1) begin
             for(int j = 0; j < 7; j += 1) begin
                panel[i][j] <= 2'b00; 
             end
         end   
       end
    WAIT:
      begin
        //because we may raise invalid move during PUT state
        invalid_move <=1'b0;
        if (falling_edge_put) begin
          state <= PUT;
        end else if (falling_edge_left) begin
          state <= MOVE_L;
        end else if (falling_edge_right) begin
          state <= MOVE_R;
        end else begin
          state <= WAIT;
        end
      end
    MOVE_L:
      begin
        if (play == 7'b1000000) begin
          play <= 7'b0000001;
          state <= WAIT;
      end else begin
          play  <= play<<1;
          state <=WAIT;
        end
      end
    MOVE_R:
      begin
        if (play == 7'b0000001) begin
          play  <= 7'b1000000;
          state <= WAIT;
        end else begin
          play<=play>> 1;
          state <= WAIT;
        end
      end
    PUT:
      begin
        // FIRST COL PUT
        if (play==7'b1000000) begin
           if (full_cols[0]==1'b1) begin
               state<=WAIT;
               invalid_move<=1'b1;
           end else begin
              state<=CHECK_WINNER;
              if(turn) begin
                panel[col_0_counter][0]<=2'b10;
              end else begin
                panel[col_0_counter][0]<=2'b01;
              end
              col_0_counter<= col_0_counter + 1 ;
           end
        end
        // SECOND COL PUT
       else if (play==7'b0100000) begin
           if (full_cols[1]==1'b1) begin
               state<=WAIT;
               invalid_move<=1'b1;
           end else begin
             state<=CHECK_WINNER;
              if(turn) begin
                panel[col_1_counter][1]<=2'b10;
              end else begin
                panel[col_1_counter][1]<=2'b01;
              end
              col_1_counter<= col_1_counter + 1 ;
           end
        end
        
        // THIRD COL PUT
       else if (play==7'b0010000) begin
           if (full_cols[2]==1'b1) begin
               state<=WAIT;
               invalid_move<=1'b1;
           end else begin
             state<=CHECK_WINNER;
              if(turn) begin
                panel[col_2_counter][2]<=2'b10;
              end else begin
                panel[col_2_counter][2]<=2'b01;
              end
              col_2_counter<= col_2_counter + 1 ;
           end
        end
        
        //FOURTH COL PUT
       else if (play==7'b0001000) begin
           if (full_cols[3]==1'b1) begin
               state<=WAIT;
               invalid_move<=1'b1;
           end else begin
             state<=CHECK_WINNER;
              if(turn) begin
                panel[col_3_counter][3]<=2'b10;
              end else begin
                panel[col_3_counter][3]<=2'b01;
              end
              col_3_counter<= col_3_counter + 1 ;
           end
        end
        //FIFTH COL PUT
       else if (play==7'b0000100) begin
           if (full_cols[4]==1'b1) begin
               state<=WAIT;
               invalid_move<=1'b1;
           end else begin
             state<=CHECK_WINNER;
              if(turn) begin
                panel[col_4_counter][4]<=2'b10;
              end else begin
                panel[col_4_counter][4]<=2'b01;
              end
              col_4_counter<= col_4_counter + 1 ;
           end
        end
        //SIXTH COL PUT
       else if (play==7'b0000010) begin
           if (full_cols[5]==1'b1) begin
               state<=WAIT;
               invalid_move<=1'b1;
           end else begin
             state<=CHECK_WINNER;
              if(turn) begin
                panel[col_5_counter][5]<=2'b10;
              end else begin
                panel[col_5_counter][5]<=2'b01;
              end
              col_5_counter<= col_5_counter + 1 ;
           end
        end
        //SEVENTH COL PUT
       else if (play==7'b0000001) begin
           if (full_cols[6]==1'b1) begin
               state<=WAIT;
               invalid_move<=1'b1;
           end else begin
             state<=CHECK_WINNER;
              if(turn) begin
                panel[col_6_counter][6]<=2'b10;
              end else begin
                panel[col_6_counter][6]<=2'b01;
              end
              col_6_counter<= col_6_counter + 1 ;
           end
        end
       else begin
           //something went wrong with play column so we need to reset it
           play <= 7'b1000000;
           invalid_move<=1'b1;
           state<=WAIT;
         end
      end
    CHECK_WINNER:
    begin
      state<=CHECK_WINNER2;
      end
    CHECK_WINNER2:
    begin
    if (win_a==1||win_b==1) 
        state<=END;
      else if (full_panel==1'b1) begin
        state<=END;
      end else 
        turn<=~turn;
        state <=WAIT;
    end
    END:
    begin
        state<=END;
    end
endcase
end
end


PanelDisplay panelzz(.clk(clk),
                     .rst(rst),
                     .hsync(hsync),
                     .vsync(vsync),
                     .panel(panel),
                     .turn(turn),
                     .play(play),
                     .red(red),
                     .blue(blue),
                     .green(green)
                      );
                     








endmodule

