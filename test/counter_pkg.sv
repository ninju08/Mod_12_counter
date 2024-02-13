package counter_pkg;

  int number_of_transactions = 1;

  `include "counter_trans.sv"
  `include "counter_gen.sv"
  `include "counter_write_monitor.sv"
  `include "counter_write_driver.sv"
  `include "counter_read_monitor.sv"
  `include "counter_sb.sv"
  `include "counter_ref_model.sv"
  `include "counter_env.sv"
  `include "test.sv"

endpackage

