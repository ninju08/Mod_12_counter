class counter_ref_model;
 
 counter_trans wrmon_data ;

 static bit [3:0] ref_data_out =0 ;

 mailbox #(counter_trans) wr2rm;
 mailbox #(counter_trans) rm2sb;
  

 
 function new(mailbox #(counter_trans) wr2rm,
               mailbox #(counter_trans) rm2sb);
        this.wr2rm = wr2rm;
        this.rm2sb = rm2sb ;
endfunction 

 task verify(input counter_trans wrmon_data);
   begin 
    if(wrmon_data.reset==1)
     ref_data_out <= 4'd0;
      
       
       else if(wrmon_data.load==1)
          ref_data_out <= wrmon_data.data_in;
          
           
            else if (wrmon_data.mode==1'b0)
          begin
                       
             if(ref_data_out==4'd11)
        ref_data_out<= 4'd0;
                        else 
                          ref_data_out <= ref_data_out + 1'b1;

     end 
       
       else if(wrmon_data.mode==1'b1)
           begin
                   
                    if(ref_data_out == 4'd0)
          ref_data_out <= 4'd11 ;
                     else 
                       ref_data_out <= ref_data_out-1'b1 ;

      end    
         
    
   end
endtask 


 virtual task start();
   fork 
        forever 
          begin 
            wr2rm.get(wrmon_data);
            verify(wrmon_data);
            wrmon_data.data_out = ref_data_out ;
            rm2sb.put(wrmon_data);
          end 
   join_none 
endtask 

endclass
