library verilog;
use verilog.vl_types.all;
entity scheduling_logic is
    port(
        instruction1    : in     vl_logic_vector(15 downto 0);
        dependency      : in     vl_logic_vector(15 downto 0);
        instruction_available: in     vl_logic;
        dependency_add  : out    vl_logic_vector(15 downto 0);
        sram_address_store: out    vl_logic_vector(7 downto 0);
        sram_address_load: out    vl_logic_vector(7 downto 0);
        source1         : out    vl_logic_vector(3 downto 0);
        source2         : out    vl_logic_vector(3 downto 0);
        read_instruction1: out    vl_logic;
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
end scheduling_logic;
