library verilog;
use verilog.vl_types.all;
entity tb_scheduling_logic is
    generic(
        CLK_PERIOD      : integer := 5
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
end tb_scheduling_logic;
