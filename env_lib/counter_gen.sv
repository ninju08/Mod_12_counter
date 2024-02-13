class counter_gen ;

  counter_trans gen_trans ;

  counter_trans data2send ;

 mailbox #(counter_trans) gen2wr ;

 function new(mailbox #(counter_trans) gen2wr );
     this.gen2wr = gen2wr ;
     this.gen_trans = new();
 endfunction 

 virtual task start ();
   fork 
     begin 
      for(int i = 0;i<number_of_transactions;i++)
       begin 
         assert(gen_trans.randomize());
         data2send = new gen_trans ;
         gen2wr.put(data2send);
       end 
    end 
  join_none 
 endtask 


endclass
