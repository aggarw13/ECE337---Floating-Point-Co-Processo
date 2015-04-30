library verilog;
use verilog.vl_types.all;
entity tb_dependency_remove is
    generic(
        CLK_PERIOD      : integer := 5;
        NUM_BLOCKS      : integer := 6
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of NUM_BLOCKS : constant is 1;
end tb_dependency_remove;
