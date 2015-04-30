library verilog;
use verilog.vl_types.all;
entity dependancy_reg is
    generic(
        numReg          : integer := 16
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        dependency_set  : in     vl_logic_vector;
        dependency_remove: in     vl_logic_vector;
        dependency_exists: out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of numReg : constant is 1;
end dependancy_reg;
