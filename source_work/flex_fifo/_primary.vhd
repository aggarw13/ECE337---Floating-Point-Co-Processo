library verilog;
use verilog.vl_types.all;
entity flex_fifo is
    generic(
        WIDTH           : integer := 8;
        DEPTH           : integer := 8;
        BITS_WIDTH      : integer := 3;
        BITS_DEPTH      : integer := 3
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        r_enable        : in     vl_logic;
        w_enable        : in     vl_logic;
        w_data          : in     vl_logic_vector;
        r_data          : out    vl_logic_vector;
        full            : out    vl_logic;
        empty           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DEPTH : constant is 1;
    attribute mti_svvh_generic_type of BITS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of BITS_DEPTH : constant is 1;
end flex_fifo;
