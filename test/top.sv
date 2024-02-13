module top();

   //Import counter_pkg
   import counter_pkg::*;   
    
   parameter cycle = 10;
  
   reg clk;

   //Instantiate the interface
   counter_if DUV_IF(clk);

   //Declare a handle for counter_base_test as base_test_h
   counter_base_test base_test_h;
   
   //Declare a handle for counter_test_extnd1 as test_ext_h1
  // counter_test_extnd1 ext_test_h1;
   
   //Instantiate the DUV
   mod12_counter counter (.clk        (clk),
                 .data_in    (DUV_IF.data_in),
                 .data_out   (DUV_IF.data_out),
                 .mode       (DUV_IF.mode),
                 .reset      (DUV_IF.reset)
                ); 

   //Generate the clock
   initial
      begin
         clk = 1'b0;
         forever #(cycle/2) clk = ~clk;
      end
   
   initial
      begin
	 
	`ifdef VCS
         $fsdbDumpvars(0, top);
        `endif

	//Create the objects for different testcases and pass the interface instances as arguments
         //Call the virtual task build and virtual task run       
         if($test$plusargs("TEST1"))
            begin
               base_test_h = new(DUV_IF,DUV_IF, DUV_IF);
               number_of_transactions = 100;
               base_test_h.build();
               base_test_h.run();
               $finish;
            end

         /*if($test$plusargs("TEST2"))
            begin
               ext_test_h1 = new(DUV_IF,DUV_IF, DUV_IF, DUV_IF);
               number_of_transactions = 500;
               ext_test_h1.build();
               ext_test_h1.run(); 
               $finish;
            end*/
      end
endmodule

