library verilog;
use verilog.vl_types.all;
entity dependency_remove is
    generic(
        NUM_BLOCKS      : integer := 6
    );
    port(
        result_address  : in     vl_logic_vector;
        remove_enable   : in     vl_logic_vector;
        dependency_remove: out    vl_logic_vector(15 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of NUM_BLOCKS : constant is 1;
end dependency_remove;
