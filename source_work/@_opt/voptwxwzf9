library verilog;
use verilog.vl_types.all;
entity flex_indexer is
    generic(
        NUM_CNT_BITS    : integer := 4
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        clear           : in     vl_logic;
        count_enable    : in     vl_logic;
        rollover_val    : in     vl_logic_vector;
        count_out       : out    vl_logic_vector;
        rollover_flag   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_CNT_BITS : constant is 1;
end flex_indexer;
