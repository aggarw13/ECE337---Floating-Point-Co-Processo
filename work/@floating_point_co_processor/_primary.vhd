library verilog;
use verilog.vl_types.all;
entity Floating_point_co_processor is
    generic(
        INSTRUCT_WIDTH  : integer := 16;
        ALU_BLOCKS      : integer := 6
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INSTRUCT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ALU_BLOCKS : constant is 1;
end Floating_point_co_processor;
