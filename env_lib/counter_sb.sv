class counter_sb ;
 
 event DONE ;

static int data_verified = 0;
static int rm_data_count = 0;
static int mon_data_count = 0;

   counter_trans rm_data;
   counter_trans rcvd_data;
   counter_trans cov_data;

 mailbox #(counter_trans) rm2sb;
 mailbox #(counter_trans) mon2sb ;

 covergroup mem_coverage ;
   option.per_instance = 1;

   DATA:coverpoint cov_data.data_in{ bins data_in [] ={[0:11]};}
   LD:coverpoint cov_data.load;
   MD:coverpoint cov_data.mode ;
   RST:coverpoint cov_data.reset{bins ZERO[] ={0,1} ;}
   OUT:coverpoint cov_data.data_out{bins data_out [] = {[0:11]};}
   DATAXMODE :cross DATA,LD ;
 endgroup 

 function new( mailbox #(counter_trans) rm2sb,
                mailbox #(counter_trans) mon2sb) ;
         this.rm2sb = rm2sb ;
         this.mon2sb = mon2sb ;
         mem_coverage = new ;
 endfunction 


  virtual task start();
     fork
       forever
         begin
            rm2sb.get(rm_data);
             rm_data_count++;
             mon2sb.get(rcvd_data);
              mon_data_count++;
             check(rcvd_data);
          end
      join_none
  endtask


 virtual task check(counter_trans rc_data);
   begin 
     if(rm_data.data_out==rc_data.data_out)
        
          $display("data matched"); 
     else 
          $display("data not matched ");
     
         cov_data = new rm_data;
         mem_coverage.sample();
         data_verified++;
     if(data_verified >= (number_of_transactions+2))
       begin 
       -> DONE ;
      end 
  end 
 endtask 

  virtual function void report();
   $display("--------------------------SCOREBOARD REPORT--------------------------------\n");
  // $display("%d",rm_data);
   //$display("%0d Read data verified\n",data_verified);
$display(" %0d Read Data Generated, %0d Read Data Recevied, %0d Read Data Verified \n",
                                             rm_data_count,mon_data_count,data_verified);  
 $display("-----------------------------------------------------------------------------\n");
endfunction 
 endclass
