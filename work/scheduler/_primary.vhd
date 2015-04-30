library verilog;
use verilog.vl_types.all;
entity scheduler is
    generic(
        INSTRUCT_WIDTH  : integer := 16
    );
    port(
        n_rst           : in     vl_logic;
        clk             : in     vl_logic;
        instruction     : in     vl_logic_vector;
        add_instruction : in     vl_logic;
        drop_dependency : in     vl_logic_vector(15 downto 0);
        buffer_full     : out    vl_logic;
        sram_address_store: out    vl_logic_vector(7 downto 0);
        sram_address_load: out    vl_logic_vector(7 downto 0);
        source1         : out    vl_logic_vector(3 downto 0);
        source2         : out    vl_logic_vector(3 downto 0);
        store2_enable   : out    vl_logic;
        store1_enable   : out    vl_logic;
        load_enable     : out    vl_logic;
        add_enable      : out    vl_logic;
        sub_enable      : out    vl_logic;
        mul_enable      : out    vl_logic;
        sin_enable      : out    vl_logic;
        neg_enable      : out    vl_logic;
        abs_enable      : out    vl_logic;
        move_enable     : out    vl_logic;
        load_dest       : out    vl_logic_vector(3 downto 0);
        add_dest        : out    vl_logic_vector(3 downto 0);
        sub_dest        : out    vl_logic_vector(3 downto 0);
        mul_dest        : out    vl_logic_vector(3 downto 0);
        sin_dest        : out    vl_logic_vector(3 downto 0);
        neg_dest        : out    vl_logic_vector(3 downto 0);
        abs_dest        : out    vl_logic_vector(3 downto 0);
        move_dest       : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INSTRUCT_WIDTH : constant is 1;
end scheduler;
