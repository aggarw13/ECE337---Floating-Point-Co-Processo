library verilog;
use verilog.vl_types.all;
entity Floating_point_co_processor_design is
    generic(
        INSTRUCT_WIDTH  : integer := 16;
        ALU_BLOCKS      : integer := 8
    );
    port(
        apb_clk         : in     vl_logic;
        clk             : in     vl_logic;
        npreset         : in     vl_logic;
        n_rst           : in     vl_logic;
        paddr           : in     vl_logic_vector(31 downto 0);
        pselec1         : in     vl_logic;
        penable         : in     vl_logic;
        pwrite          : in     vl_logic;
        pwdata          : in     vl_logic_vector(31 downto 0);
        pready          : out    vl_logic;
        prdata          : out    vl_logic_vector(31 downto 0);
        pslverr         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INSTRUCT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ALU_BLOCKS : constant is 1;
end Floating_point_co_processor_design;
