module PanelDisplay (
input logic clk,
input logic rst,
output logic hsync,
output logic vsync,
input logic [6:0] play,              
input logic [1:0] panel [0:5][0:6],
input logic turn,
output logic [3:0] red,
output logic [3:0] green,
output logic [3:0] blue);


localparam HS_START = 640 + 16;            // horizontal sync start
localparam HS_END   = 640 + 16 + 96;       // horizontal sync end
localparam H_ACTIVE_END = 640;             // horizontal active pixel start
localparam VS_START = 480 + 10;            // vertical sync start
localparam VS_END = 480 + 10 + 2;          // vertical sync end
localparam V_ACTIVE_END = 480;             // vertical active pixel end
localparam LINE_LEN   = 800;               // complete line (pixels)
localparam LINE_NUM = 525;                 // complete screen (lines)


logic [9:0] col;  // line position
logic [9:0] row;  // screen position

logic [9:0] x;  // Active Screen Pixel Position x
logic [8:0] y;  // Active Screen Pixel Position y

//Activate Vsync Hsync when inside conditions
assign hsync = ~((col >= HS_START) & (col < HS_END));
assign vsync = ~((row >= VS_START) & (row < VS_END));


// keep x and y bound within the active pixels
assign x = (col >= H_ACTIVE_END) ? 1000 : (col); //1000 dummy value to send only black when out of bounds
assign y = (row >= V_ACTIVE_END) ? 1000 : (row); //1000 dummy value to send only black when out of bounds

//Create Pixel Clock 
logic pixel_clk;
always_ff @(posedge clk ,posedge rst)
  begin
      if (rst)
        pixel_clk <= 0;
      else
        pixel_clk <= ~pixel_clk;
  end


 always_ff @(posedge clk ,posedge rst)
    begin
        if (rst)  // reset to start of frame
			begin
            row <= 0;
            col <= 0;
			end
		  else
		  begin
        if (pixel_clk)  // once per pixel
        begin
            if (col == LINE_LEN-1)  // end of line
            begin
                col <= 0;
                row <= row + 1;
            end
            else 
                col <= col + 1;

            if (row == LINE_NUM-1) 
                row <= 0;
				end
        end
    end
    
    

always_comb
begin
  
     //0,0
         if ( (x >= 21 + 91*0) && (x <= 21+49 + 91*0) && (y >= 10 + 68*0) && (y <=  10 + 49 + 68*0) ) begin
           if (panel[5][0]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[5][0]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[5][0]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
            
     //0,1
          
          end else if ( (x >= 21 + 91*1) && (x <= 21+49 + 91*1) && (y >= 10 + 68*0) && (y <=  10 + 49 + 68*0) ) begin
           if (panel[5][1]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[5][1]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[5][1]==2'b10) begin
                 red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
     //0,2     
          end else if ( (x >= 21 + 91*2) && (x <= 21+49 + 91*2) && (y >= 10 + 68*0) && (y <=  10 + 49 + 68*0) ) begin
          if (panel[5][2]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[5][2]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[5][2]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //0,3
      
          end else if ( (x >= 21 + 91*3) && (x <= 21+49 + 91*3) && (y >= 10 + 68*0) && (y <=  10 + 49 + 68*0) ) begin
          if (panel[5][3]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[5][3]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[5][3]==2'b10) begin
               red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //0,4
          
          end else if ( (x >= 21 + 91*4) && (x <= 21+49 + 91*4) && (y >= 10 + 68*0) && (y <=  10 + 49 + 68*0) ) begin
         if (panel[5][4]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[5][4]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[5][4]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
      //0,5
          
          end else if ( (x >= 21 + 91*5) && (x <= 21+49 + 91*5) && (y >= 10 + 68*0) && (y <=  10 + 49 + 68*0) ) begin
          if (panel[5][5]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[5][5]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[5][5]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //0,6
     end else   if ( (x >= 21 + 91*6) && (x <= 21+49 + 91*6) && (y >= 10 + 68*0) && (y <=  10 + 49 + 68*0) ) begin
         if (panel[5][6]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[5][6]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[5][6]==2'b10) begin
                 red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
          
     //1,0
          
          end else if ( (x >= 21 + 91*0) && (x <= 21+49 + 91*0) && (y >= 10 + 68*1) && (y <=  10 + 49 + 68*1) ) begin
          if (panel[4][0]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[4][0]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[4][0]==2'b10) begin
                 red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
    //1,1    
      
        end else if ( (x >= 21 + 91*1) && (x <= 21+49 + 91*1) && (y >= 10 + 68*1) && (y <=  10 + 49 + 68*1) ) begin
           if (panel[4][1]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[4][1]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[4][1]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
          
     //1,2     
          end else if ( (x >= 21 + 91*2) && (x <= 21+49 + 91*2) && (y >= 10 + 68*1) && (y <=  10 + 49 + 68*1) ) begin
              if (panel[4][2]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[4][2]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[4][2]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //1,3
      
          end else if ( (x >= 21 + 91*3) && (x <= 21+49 + 91*3) && (y >= 10 + 68*1) && (y <=  10 + 49 + 68*1) ) begin
                if (panel[4][3]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[4][3]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[4][3]==2'b10) begin
               red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //1,4
          
          end else if ( (x >= 21 + 91*4) && (x <= 21+49 + 91*4) && (y >= 10 + 68*1) && (y <=  10 + 49 + 68*1) ) begin
               if (panel[4][4]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[4][4]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[4][4]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //1,5
          
          end else if ( (x >= 21 + 91*5) && (x <= 21+49 + 91*5) && (y >= 10 + 68*1) && (y <=  10 + 49 + 68*1) ) begin
               if (panel[4][5]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[4][5]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[4][5]==2'b10) begin
              red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end 
          
          
          
          
      //1,6
      end else  if ( (x >= 21 + 91*6) && (x <= 21+49 + 91*6) && (y >= 10 + 68*1) && (y <=  10 + 49 + 68*1) ) begin
              if (panel[4][6]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[4][0]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[4][0]==2'b10) begin
               red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
          
     //2,0
          
          end else if ( (x >= 21 + 91*0) && (x <= 21+49 + 91*0) && (y >= 10 + 68*2) && (y <=  10 + 49 + 68*2) ) begin
              if (panel[3][0]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[3][0]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[3][0]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
     //2,1     
          end else if ( (x >= 21 + 91*1) && (x <= 21+49 + 91*1) && (y >= 10 + 68*2) && (y <=  10 + 49 + 68*2) ) begin
           if (panel[3][1]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[3][1]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[3][1]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
      //2,2
      
          end else if ( (x >= 21 + 91*2) && (x <= 21+49 + 91*2) && (y >= 10 + 68*2) && (y <=  10 + 49 + 68*2) ) begin
            if (panel[3][2]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[3][2]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[3][2]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
      //2,3
          
          end else if ( (x >= 21 + 91*3) && (x <= 21+49 + 91*3) && (y >= 10 + 68*2) && (y <=  10 + 49 + 68*2) ) begin
            if (panel[3][3]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[3][3]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[3][3]==2'b10) begin
                 red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
      //2,4
          
          end else if ( (x >= 21 + 91*4) && (x <= 21+49 + 91*4) && (y >= 10 + 68*2) && (y <=  10 + 49 + 68*2) ) begin
            if (panel[3][4]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[3][4]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[3][4]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end


     //2,5
       end else if ( (x >= 21 + 91*5) && (x <= 21+49 + 91*5) && (y >= 10 + 68*2) && (y <=  10 + 49 + 68*2) ) begin
           if (panel[3][5]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[3][5]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[3][5]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
          
     //2,6
          
          end else if ( (x >= 21 + 91*6) && (x <= 21+49 + 91*6) && (y >= 10 + 68*2) && (y <=  10 + 49 + 68*2) ) begin
         if (panel[3][6]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[3][6]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[3][6]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
     //3,0     
          end else if ( (x >= 21 + 91*0) && (x <= 21+49 + 91*0) && (y >= 10 + 68*3) && (y <=  10 + 49 + 68*3) ) begin
             if (panel[2][0]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[2][0]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[2][0]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //3,1
      
          end else if ( (x >= 21 + 91*1) && (x <= 21+49 + 91*1) && (y >= 10 + 68*3) && (y <=  10 + 49 + 68*3) ) begin
            if (panel[2][1]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[2][1]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[2][1]==2'b10) begin
               red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
      //3,2
          
          end else if ( (x >= 21 + 91*2) && (x <= 21+49 + 91*2) && (y >= 10 + 68*3) && (y <=  10 + 49 + 68*3) ) begin
                if (panel[2][2]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[2][2]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[2][2]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
      //3,3
          
          end else if ( (x >= 21 + 91*3) && (x <= 21+49 + 91*3) && (y >= 10 + 68*3) && (y <=  10 + 49 + 68*3) ) begin
                 if (panel[2][3]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[2][3]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[2][3]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end


     //3,4
     end else  if ( (x >= 21 + 91*4) && (x <= 21+49 + 91*4) && (y >= 10 + 68*3) && (y <=  10 + 49 + 68*3) ) begin
              if (panel[2][4]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[2][4]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[2][4]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
     //3,5
          
          end else if ( (x >= 21 + 91*5) && (x <= 21+49 + 91*5) && (y >= 10 + 68*3) && (y <=  10 + 49 + 68*3) ) begin
                  if (panel[2][5]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[2][5]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[2][5]==2'b10) begin
                 red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
     //3,6     
          end else if ( (x >= 21 + 91*6) && (x <= 21+49 + 91*6) && (y >= 10 + 68*3) && (y <=  10 + 49 + 68*3) ) begin
                if (panel[2][6]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[2][6]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[2][6]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
      //4,0
      
          end else if ( (x >= 21 + 91*0) && (x <= 21+49 + 91*0) && (y >= 10 + 68*4) && (y <=  10 + 49 + 68*4) ) begin
               if (panel[1][0]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[1][0]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[1][0]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
      //4,1
          
          end else if ( (x >= 21 + 91*1) && (x <= 21+49 + 91*1) && (y >= 10 + 68*4) && (y <=  10 + 49 + 68*4) ) begin
                if (panel[1][1]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[1][1]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[1][1]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
      //4,2
          
          end else if ( (x >= 21 + 91*2) && (x <= 21+49 + 91*2) && (y >= 10 + 68*4) && (y <=  10 + 49 + 68*4) ) begin
                if (panel[1][2]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[1][2]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[1][2]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
          
          
     //4,3
      end else  if ( (x >= 21 + 91*3) && (x <= 21+49 + 91*3) && (y >= 10 + 68*4) && (y <=  10 + 49 + 68*4) ) begin
                 if (panel[1][3]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[1][3]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[1][3]==2'b10) begin
               red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
          
     //4,4
          
          end else if ( (x >= 21 + 91*4) && (x <= 21+49 + 91*4) && (y >= 10 + 68*4) && (y <=  10 + 49 + 68*4) ) begin
              if (panel[1][4]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[1][4]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[1][4]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
     //4,5    
          end else if ( (x >= 21 + 91*5) && (x <= 21+49 + 91*5) && (y >= 10 + 68*4) && (y <=  10 + 49 + 68*4) ) begin
             if (panel[1][5]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[1][5]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[1][5]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //4,6
      
          end else if ( (x >= 21 + 91*6) && (x <= 21+49 + 91*6) && (y >= 10 + 68*4) && (y <=  10 + 49 + 68*4) ) begin
                if (panel[1][6]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[1][6]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[1][6]==2'b10) begin
               red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //5,0
          
          end else if ( (x >= 21 + 91*0) && (x <= 21+49 + 91*0) && (y >= 10 + 68*5) && (y <=  10 + 49 + 68*5) ) begin
                 if (panel[0][0]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[0][0]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[0][0]==2'b10) begin
                 red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
      //5,1
          
          end else if ( (x >= 21 + 91*1) && (x <= 21+49 + 91*1) && (y >= 10 + 68*5) && (y <=  10 + 49 + 68*5) ) begin
                 if (panel[0][1]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[0][1]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[0][1]==2'b10) begin
               red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end


     //5,2
          end else if ( (x >= 21 + 91*2) && (x <= 21+49 + 91*2) && (y >= 10 + 68*5) && (y <=  10 + 49 + 68*5) ) begin
               if (panel[0][2]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[0][2]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[0][2]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
          
     //5,3
          
          end else if ( (x >= 21 + 91*3) && (x <= 21+49 + 91*3) && (y >= 10 + 68*5) && (y <=  10 + 49 + 68*5) ) begin
              if (panel[0][3]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[0][3]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[0][3]==2'b10) begin
                 red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      
     //5,4     
          end else if ( (x >= 21 + 91*4) && (x <= 21+49 + 91*4) && (y >= 10 + 68*5) && (y <=  10 + 49 + 68*5) ) begin
              if (panel[0][4]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[0][4]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[0][4]==2'b10) begin
                 red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //5,5
      
          end else if ( (x >= 21 + 91*5) && (x <= 21+49 + 91*5) && (y >= 10 + 68*5) && (y <=  10 + 49 + 68*5) ) begin
                if (panel[0][5]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[0][5]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[0][5]==2'b10) begin
                red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
      //5,6
          
          end else if ( (x >= 21 + 91*6) && (x <= 21+49 + 91*6) && (y >= 10 + 68*5) && (y <=  10 + 49 + 68*5) ) begin
          if (panel[0][6]==2'b00) begin
                red=0;
                blue=0;
                green=0;
           end else if (panel[0][6]==2'b01) begin
                red=5;
                blue=0;
                green=0;
          end else if (panel[0][6]==2'b10) begin
               red=0;
                blue=0;
                green=5;
          end else begin
              red=5;
              blue=0;
              green=5;
            end
            
     //play row
     
     //p,0
      end else if ( (x >= 21 + 91*0) && (x <= 21+49 + 91*0) && (y >= 10 +25 + 68*6) && (y <=  10 + 49 + 68*6) ) begin
          if (play==7'b1000000) begin
            if (turn==0)begin
                red=5;
                blue=0;
                green=0;
              end else begin
                red=0;
                blue=0;
                green=5;
              end
            end
            else begin
              red=0;
              blue=0;
              green=0;
            end
  
     
     //p,1
     
       end else if ( (x >= 21 + 91*1) && (x <= 21+49 + 91*1) && (y >= 10 +25 + 68*6) && (y <=  10 + 49 + 68*6) ) begin
          if (play==7'b0100000) begin
            if (turn==0)begin
                red=5;
                blue=0;
                green=0;
              end else begin
                red=0;
                blue=0;
                green=5;
              end
            end
            else begin
              red=0;
              blue=0;
              green=0;
            end
  
     //p,2
     
     
       end else if ( (x >= 21 + 91*2) && (x <= 21+49 + 91*2) && (y >= 10 +25 + 68*6) && (y <=  10 + 49 + 68*6) ) begin
          if (play==7'b0010000) begin
            if (turn==0)begin
                red=5;
                blue=0;
                green=0;
              end else begin
                red=0;
                blue=0;
                green=5;
              end
            end
            else begin
              red=0;
              blue=0;
              green=0;
            end
      
     //p,3
     
       end else if ( (x >= 21 + 91*3) && (x <= 21+49 + 91*3) && (y >= 10 +25 + 68*6) && (y <=  10 + 49 + 68*6) ) begin
          if (play==7'b0001000) begin
            if (turn==0)begin
                red=5;
                blue=0;
                green=0;
              end else begin
                red=0;
                blue=0;
                green=5;
              end
            end
            else begin
              red=0;
              blue=0;
              green=0;
            end
   
       
     //p,4
     
       end else if ( (x >= 21 + 91*4) && (x <= 21+49 + 91*4) && (y >= 10 +25 + 68*6) && (y <=  10 + 49 + 68*6) ) begin
          if (play==7'b0000100) begin
            if (turn==0)begin
                red=5;
                blue=0;
                green=0;
              end else begin
                red=0;
                blue=0;
                green=5;
              end
            end
            else begin
              red=0;
              blue=0;
              green=0;
            end

     
     //p,5
       end else if ( (x >= 21 + 91*5) && (x <= 21+49 + 91*5) && (y >= 10 +25 + 68*6) && (y <=  10 + 49 + 68*6) ) begin
          if (play==7'b0000010) begin
            if (turn==0)begin
                red=5;
                blue=0;
                green=0;
              end else begin
                red=0;
                blue=0;
                green=5;
              end
            end
            else begin
              red=0;
              blue=0;
              green=0;
            end

     //p,6  
            
      end else if ( (x >= 21 + 91*6) && (x <= 21+49 + 91*6) && (y >= 10 +25 + 68*6) && (y <=  10 + 49 + 68*6) ) begin
          if (play==7'b0000001) begin
            if (turn==0)begin
                red=5;
                blue=0;
                green=0;
              end else begin
                red=0;
                blue=0;
                green=5;
              end
            end
            else begin
              red=0;
              blue=0;
              green=0;
            end

         // for all otther x,y and for when we are outside active pixel 
          end else 
            begin
              red=0;
              blue=0;
              green=0;
            end
            
            
            
            
            
            

end

endmodule


