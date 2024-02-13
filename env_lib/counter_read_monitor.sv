class counter_read_monitor ;

 virtual counter_if.RD_MON_MP rd_mon_if ;

 counter_trans rddata ,data2sb ;

 
 mailbox #(counter_trans) mon2sb ;

 function new(virtual counter_if.RD_MON_MP rd_mon_if,
              mailbox #(counter_trans) mon2sb );
     this.rd_mon_if = rd_mon_if ;
     this.mon2sb =  mon2sb ;
    this.rddata = new ;
 endfunction 

 virtual task monitor ();
 begin 
  @(rd_mon_if.rd_mon_cb);
   begin 
    rddata.data_out = rd_mon_if.rd_mon_cb.data_out;
    rddata.display("DATA FROM READ MONITOR");
   end 
 end 
 endtask 

 virtual task start();
   fork 
     forever  
       begin 
          monitor();
         
          data2sb = new rddata;
         
          mon2sb.put(data2sb);
       end 
    join_none 
endtask 

endclass

