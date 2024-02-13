interface counter_if (input bit clk);

  logic [3:0] data_in ;
  logic [3:0] data_out ;
  logic reset ;
  logic load ;
  logic mode ;

 
 // write driver clocking block 

  clocking wr_drv_cb@(posedge clk);
    default input #1 output #1 ;
    output data_in ;
    output reset ;
    output load ;
    output mode ;
  endclocking 


  // write monitor clocking block 

  clocking wr_mon_cb@(posedge clk);
   default input #1 output #1 ;
    input data_in ;
    input reset ;
    input load ;
    input mode ; 
  endclocking 

 //read monitor clocking block 

  clocking rd_mon_cb@(posedge clk);
   default input #1 output #1 ;
   input data_out ;
  endclocking 

 //write driver modport 

  modport WR_DRV_MP (clocking wr_drv_cb);

//write monitor modport 

  modport WR_MON_MP (clocking wr_mon_cb);

//read monitor modport 

  modport RD_MON_MP (clocking rd_mon_cb);


endinterface
