library verilog;
use verilog.vl_types.all;
entity instruction_parser is
    generic(
        t               : integer := 0
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        address_bus     : in     vl_logic_vector(31 downto 0);
        data_bus        : in     vl_logic_vector(31 downto 0);
        read_instruction: in     vl_logic;
        valid_data      : in     vl_logic;
        dependency_remove: in     vl_logic_vector(15 downto 0);
        read_data_buff  : out    vl_logic_vector(31 downto 0);
        read_data_enable: in     vl_logic;
        instruction_buffer_full: in     vl_logic;
        instruction_out : out    vl_logic_vector(15 downto 0);
        add_instruction : out    vl_logic;
        out_reg         : out    vl_logic_vector(3 downto 0);
        read_error      : out    vl_logic;
        write_error     : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of t : constant is 1;
end instruction_parser;
