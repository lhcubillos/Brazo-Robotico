module debouncer(
    input clk, //this is a 50MHz clock provided on FPGA pin PIN_Y2
    input PB,  //this is the input to be debounced
	 //input rst,
    output reg PB_state  //this is the debounced switch
);
/*This module debounces the pushbutton PB.
 *It can be added to your project files and called as is:
 *DO NOT EDIT THIS MODULE
 */
	reg PB_sync_0;
	reg PB_sync_1;
	reg [15:0] PB_cnt;

	/*
	always @(posedge(rst))
	begin
	if (rst) PB_sync_0 = 0;
	if (rst) PB_sync_1 = 0;
	if (rst) PB_cnt = 0;
	if (rst) PB_state = 0;
	end
	*/


	// Synchronize the switch input to the clock

	always @(posedge clk) PB_sync_0 <= PB;
	always @(posedge clk) PB_sync_1 <= PB_sync_0;

	// Debounce the switch
	always @(posedge clk)
	if(PB_state==PB_sync_1)
		 PB_cnt <= 0;
	else
	begin
		 PB_cnt <= PB_cnt + 1'b1;
		 if(PB_cnt == 16'hffff) PB_state <= ~PB_state;
	end


endmodule
