library verilog;
use verilog.vl_types.all;
entity upDownCounter is
    generic(
        BITSIZE         : integer := 4
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        up              : in     vl_logic;
        down            : in     vl_logic;
        count_out       : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BITSIZE : constant is 1;
end upDownCounter;
