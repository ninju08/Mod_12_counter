class counter_write_driver ;

 counter_trans data2duv ;

 mailbox #(counter_trans) gen2wr;

 virtual  counter_if.WR_DRV_MP wr_drv_if ;


 function new( virtual counter_if.WR_DRV_MP wr_drv_if ,
               mailbox #(counter_trans) gen2wr );
           this.wr_drv_if = wr_drv_if ;
            this.gen2wr = gen2wr ;
  endfunction 


 virtual task drive ();
 begin
   @(wr_drv_if.wr_drv_cb) ;
   wr_drv_if.wr_drv_cb.data_in <= data2duv.data_in;
   wr_drv_if.wr_drv_cb.mode <= data2duv.mode ;
   wr_drv_if.wr_drv_cb.load <= data2duv.load ;
   wr_drv_if.wr_drv_cb.reset<= data2duv.reset;
 end 
 
 endtask 

 virtual task start();
  fork  
    forever 
      begin 
        gen2wr.get(data2duv);
        drive();
     end 
 join_none 
 endtask 

endclass
