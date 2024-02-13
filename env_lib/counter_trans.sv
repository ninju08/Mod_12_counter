class counter_trans ;

 rand bit reset ;
 rand bit load;
 rand bit mode;
 rand bit[3:0] data_in;
      bit [3:0] data_out;


  static int trans_id;
  static int no_of_upcount ;
  static int no_of_downcount;
  static int no_of_reset_trans ;
  static int no_of_load_trans;

 constraint RST{reset dist{1:=40 ,0:=60};}
 constraint LD{load dist{1:=30 ,0:=70};}
 constraint MD{mode dist{1:=30,0:=100};}
 constraint VALID_DATA{data_in inside{[0:11]};}

 function void post_randomize();
   trans_id++;
   if(this.reset)
   no_of_reset_trans++;
   if(this.load)
   no_of_load_trans++;
   if(this.mode==0)
   no_of_upcount++;
   if(this.mode==1)
   no_of_downcount++;
  this.display("\t RANDOMIZED DATA");
 endfunction 

 virtual function void display(input string message);
  $display("=========================================================================");
  $display("message = %s",message);
  $display("data_in = %d, data_out = %d",data_in,data_out);
  $display("reset = %d, load = %d, mode=%d",reset,load,mode); 
  $display("==========================================================================");

 endfunction

endclass
