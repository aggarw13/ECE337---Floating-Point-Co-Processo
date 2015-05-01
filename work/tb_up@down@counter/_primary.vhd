library verilog;
use verilog.vl_types.all;
entity tb_upDownCounter is
    generic(
        CLK_PERIOD      : integer := 10;
        BITSIZE         : integer := 4
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of BITSIZE : constant is 1;
end tb_upDownCounter;
