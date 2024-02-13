class counter_write_monitor ;

 counter_trans wrdata;
 counter_trans data2rm;

 virtual counter_if.WR_MON_MP wr_mon_if ;

 mailbox #(counter_trans) mon2rm ;


 function new(virtual counter_if.WR_MON_MP wr_mon_if ,
              mailbox #(counter_trans) mon2rm );
     this.wr_mon_if = wr_mon_if ;
     this.mon2rm = mon2rm ;
     this.wrdata =  new;
 endfunction 


virtual task monitor();
begin   
 @(wr_mon_if.wr_mon_cb)
  
   begin 
    wrdata.data_in = wr_mon_if.wr_mon_cb.data_in ;
    wrdata.load = wr_mon_if.wr_mon_cb.load ;
    wrdata.mode = wr_mon_if.wr_mon_cb.mode ;
    wrdata.reset=wr_mon_if.wr_mon_cb.reset; 
    wrdata.display("DATA FROM WRITE MONITOR");
   end
 end 
endtask 



virtual task start ();
  fork 
   forever
      begin 
       monitor();
       data2rm = new wrdata;
       mon2rm.put(data2rm);
     end 
  join_none 
endtask 

endclass
