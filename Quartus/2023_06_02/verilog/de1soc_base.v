
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module de1soc_base(

	//////////// ADC //////////
	output		          		ADC_CONVST,
	output		          		ADC_DIN,
	input 		          		ADC_DOUT,
	output		          		ADC_SCLK,

	//////////// Audio //////////
	input 		          		AUD_ADCDAT,
	inout 		          		AUD_ADCLRCK,
	inout 		          		AUD_BCLK,
	output		          		AUD_DACDAT,
	inout 		          		AUD_DACLRCK,
	output		          		AUD_XCK,

	//////////// CLOCK //////////
	input 		          		CLOCK2_50,
	input 		          		CLOCK3_50,
	input 		          		CLOCK4_50,
	input 		          		CLOCK_50,

	//////////// SDRAM //////////
	output		    [12:0]		DRAM_ADDR,
	output		     [1:0]		DRAM_BA,
	output		          		DRAM_CAS_N,
	output		          		DRAM_CKE,
	output		          		DRAM_CLK,
	output		          		DRAM_CS_N,
	inout 		    [15:0]		DRAM_DQ,
	output		          		DRAM_LDQM,
	output		          		DRAM_RAS_N,
	output		          		DRAM_UDQM,
	output		          		DRAM_WE_N,

	//////////// I2C for Audio and Video-In //////////
	output		          		FPGA_I2C_SCLK,
	inout 		          		FPGA_I2C_SDAT,

	//////////// SEG7 //////////
	output		     [6:0]		HEX0,
	output		     [6:0]		HEX1,
	output		     [6:0]		HEX2,
	output		     [6:0]		HEX3,
	output		     [6:0]		HEX4,
	output		     [6:0]		HEX5,

	//////////// IR //////////
	input 		          		IRDA_RXD,
	output		          		IRDA_TXD,

	//////////// KEY //////////
	input 		     [3:0]		KEY,

	//////////// LED //////////
	output		     [9:0]		LEDR,

	//////////// PS2 //////////
	inout 		          		PS2_CLK,
	inout 		          		PS2_CLK2,
	inout 		          		PS2_DAT,
	inout 		          		PS2_DAT2,

	//////////// SW //////////
	input 		     [9:0]		SW,

	//////////// Video-In //////////
	input 		          		TD_CLK27,
	input 		     [7:0]		TD_DATA,
	input 		          		TD_HS,
	output		          		TD_RESET_N,
	input 		          		TD_VS,

	//////////// VGA //////////
	output		          		VGA_BLANK_N,
	output		     [7:0]		VGA_B,
	output		          		VGA_CLK,
	output		     [7:0]		VGA_G,
	output		          		VGA_HS,
	output		     [7:0]		VGA_R,
	output		          		VGA_SYNC_N,
	output		          		VGA_VS
);



//=======================================================
//  REG/WIRE declarations
//=======================================================
	parameter DATA_LEN = 32;
	parameter M = 8;
	parameter N = 8;
	parameter K = 8;
	parameter CLK_CYCLE = 10;
	parameter ADDRESS_SIZE = 4;

	wire								  i_clk;
	wire								  i_rstn;
	wire								  i_read_start;
	///////////// read  //////////
	wire    [DATA_LEN*N-1:0]	  	i_read_data;
	wire	[ADDRESS_SIZE-1:0]	  	o_read_address;
	wire	[ADDRESS_SIZE-1:0]	  	o_write_address;

	wire  						      o_wr_en;

	///////////// writeb//////////	
	wire  [DATA_LEN*N-1:0]	  		 o_write_data;
	wire   [2:0]						 o_state;
	wire							 		 o_done;


	wire [(DATA_LEN*N*M)-1:0]     read;
	wire [(DATA_LEN*N*M)-1:0]     write;
	wire [(DATA_LEN*N*M)-1:0]     read_answer;
	wire [(DATA_LEN*N*M)-1:0]     write_answer;
	wire	[ADDRESS_SIZE-1:0]	  	o_read_address_0;
	wire	[ADDRESS_SIZE-1:0]	  	o_read_address_1;
	
	reg sw_buf;
	reg mode;
	wire 					read1_start;
	wire [3:0] 			read_state0;
	wire [3:0] 			read_state1;
	

//=======================================================
//  Structural coding
//=======================================================
	
	
	assign i_clk = CLOCK_50;
	assign i_rstn = KEY[0];
	assign LEDR[0] = (read_answer == read) ? 1'b1 : 1'b0;
	assign LEDR[1] = (write_answer  == write) ? 1'b1 : 1'b0;
	assign LEDR[2] = mode;
	
	assign  read_answer =  {(32'd7 + (7)*32'd8), (32'd6 + (7)*32'd8), (32'd5 + (7)*32'd8), (32'd4 + (7)*32'd8), (32'd3 + (7)*32'd8), (32'd2 + (7)*32'd8), (32'd1 + (7)*32'd8), (32'd0 + (7)*32'd8),
				               (32'd7 + (6)*32'd8), (32'd6 + (6)*32'd8), (32'd5 + (6)*32'd8), (32'd4 + (6)*32'd8), (32'd3 + (6)*32'd8), (32'd2 + (6)*32'd8), (32'd1 + (6)*32'd8), (32'd0 + (6)*32'd8),
				               (32'd7 + (5)*32'd8), (32'd6 + (5)*32'd8), (32'd5 + (5)*32'd8), (32'd4 + (5)*32'd8), (32'd3 + (5)*32'd8), (32'd2 + (5)*32'd8), (32'd1 + (5)*32'd8), (32'd0 + (5)*32'd8),
				               (32'd7 + (4)*32'd8), (32'd6 + (4)*32'd8), (32'd5 + (4)*32'd8), (32'd4 + (4)*32'd8), (32'd3 + (4)*32'd8), (32'd2 + (4)*32'd8), (32'd1 + (4)*32'd8), (32'd0 + (4)*32'd8),
				               (32'd7 + (3)*32'd8), (32'd6 + (3)*32'd8), (32'd5 + (3)*32'd8), (32'd4 + (3)*32'd8), (32'd3 + (3)*32'd8), (32'd2 + (3)*32'd8), (32'd1 + (3)*32'd8), (32'd0 + (3)*32'd8),
				               (32'd7 + (2)*32'd8), (32'd6 + (2)*32'd8), (32'd5 + (2)*32'd8), (32'd4 + (2)*32'd8), (32'd3 + (2)*32'd8), (32'd2 + (2)*32'd8), (32'd1 + (2)*32'd8), (32'd0 + (2)*32'd8),
				               (32'd7 + (1)*32'd8), (32'd6 + (1)*32'd8), (32'd5 + (1)*32'd8), (32'd4 + (1)*32'd8), (32'd3 + (1)*32'd8), (32'd2 + (1)*32'd8), (32'd1 + (1)*32'd8), (32'd0 + (1)*32'd8),
				               (32'd7 + (0)*32'd8), (32'd6 + (0)*32'd8), (32'd5 + (0)*32'd8), (32'd4 + (0)*32'd8), (32'd3 + (0)*32'd8), (32'd2 + (0)*32'd8), (32'd1 + (0)*32'd8), (32'd0 + (0)*32'd8)};	
	
	assign  write_answer  = {(32'd7 + (0)*32'd8), (32'd6 + (0)*32'd8), (32'd5 + (0)*32'd8), (32'd4 + (0)*32'd8), (32'd3 + (0)*32'd8), (32'd2 + (0)*32'd8), (32'd1 + (0)*32'd8), (32'd0 + (0)*32'd8),
								    (32'd7 + (1)*32'd8), (32'd6 + (1)*32'd8), (32'd5 + (1)*32'd8), (32'd4 + (1)*32'd8), (32'd3 + (1)*32'd8), (32'd2 + (1)*32'd8), (32'd1 + (1)*32'd8), (32'd0 + (1)*32'd8),
								    (32'd7 + (2)*32'd8), (32'd6 + (2)*32'd8), (32'd5 + (2)*32'd8), (32'd4 + (2)*32'd8), (32'd3 + (2)*32'd8), (32'd2 + (2)*32'd8), (32'd1 + (2)*32'd8), (32'd0 + (2)*32'd8),
								    (32'd7 + (3)*32'd8), (32'd6 + (3)*32'd8), (32'd5 + (3)*32'd8), (32'd4 + (3)*32'd8), (32'd3 + (3)*32'd8), (32'd2 + (3)*32'd8), (32'd1 + (3)*32'd8), (32'd0 + (3)*32'd8),
								    (32'd7 + (4)*32'd8), (32'd6 + (4)*32'd8), (32'd5 + (4)*32'd8), (32'd4 + (4)*32'd8), (32'd3 + (4)*32'd8), (32'd2 + (4)*32'd8), (32'd1 + (4)*32'd8), (32'd0 + (4)*32'd8),
								    (32'd7 + (5)*32'd8), (32'd6 + (5)*32'd8), (32'd5 + (5)*32'd8), (32'd4 + (5)*32'd8), (32'd3 + (5)*32'd8), (32'd2 + (5)*32'd8), (32'd1 + (5)*32'd8), (32'd0 + (5)*32'd8),
								    (32'd7 + (6)*32'd8), (32'd6 + (6)*32'd8), (32'd5 + (6)*32'd8), (32'd4 + (6)*32'd8), (32'd3 + (6)*32'd8), (32'd2 + (6)*32'd8), (32'd1 + (6)*32'd8), (32'd0 + (6)*32'd8),
								    (32'd7 + (7)*32'd8), (32'd6 + (7)*32'd8), (32'd5 + (7)*32'd8), (32'd4 + (7)*32'd8), (32'd3 + (7)*32'd8), (32'd2 + (7)*32'd8), (32'd1 + (7)*32'd8), (32'd0 + (7)*32'd8)};
	
	always @(posedge i_clk, negedge i_rstn) begin
		if(!i_rstn) begin
			mode <= 0;
		end
		else begin
			if(read_state0 == 4'd8) begin
				mode <= 1;
			end
			else if(read_state1 == 4'd8)begin
				mode <= 0;
			end
			else begin
				mode <= mode;
			end
		end
	end
	always @(posedge i_clk, negedge i_rstn) begin
		if(!i_rstn) begin
			sw_buf = 0;
		end
		else begin
			sw_buf = SW[0];
		end
	end
	
	assign i_read_start = ((SW[0] == 1) && (sw_buf == 0));
	assign o_read_address = (mode) ? o_read_address_1:o_read_address_0;
	assign o_wr_en = (mode) ? o_store_start:0;
	
	M10K_read_buffer #(.DATA_LEN(DATA_LEN), .ADDRESS_SIZE(ADDRESS_SIZE), .OFFSET(0)) r0
	(	
		.i_clk		   (i_clk ),
		.i_rstn  	   (i_rstn),
		.i_read_reset  (),
		.i_read_start  (i_read_start),
		.i_read_data   (i_read_data),
		
		.o_store_mat   (read),
		.o_read_addr   (o_read_address_0),
		.o_state       (read_state0),
		.o_done	      (o_done)
	);
	
	 M10K_write #(.DATA_LEN(DATA_LEN), .ADDRESS_SIZE(ADDRESS_SIZE), .OFFSET(8)) w0
	(
		.i_clk			  (i_clk),
		.i_rstn          (i_rstn),
		.i_write_start   (o_done),
		.i_in_mat        (write_answer),
						
		.o_write_addr    (o_write_address),
		.o_write_data    (o_write_data),
		.o_write_start   (o_store_start),
		.o_state         (),
		.o_done			  (read1_start)
	);

	
	M10K_read_buffer #(.DATA_LEN(DATA_LEN), .ADDRESS_SIZE(ADDRESS_SIZE), .OFFSET(8)) r1
	(
		
		.i_clk		   (i_clk ),
		.i_rstn  	   (i_rstn),
		.i_read_reset  (),
		.i_read_start  (read1_start),
		.i_read_data   (i_read_data),
		
		.o_store_mat   (write),
		.o_read_addr   (o_read_address_1),
		.o_state       (read_state1),
		.o_done	      ()
	);
	
	M10K_16_256  MEM( 
		.i_clk				(i_clk		   ),
		.o_read_data    	(i_read_data),
		.i_write_data   	(o_write_data),
		.i_read_address   (o_read_address),
		.i_write_address  (o_write_address),
		.i_wr_en        	(o_wr_en)
	);

endmodule


