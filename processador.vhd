LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY processador IS
    PORT (
        clk, rst : IN STD_LOGIC;
        opcode : OUT unsigned(3 DOWNTO 0);
        state_out : OUT unsigned (1 DOWNTO 0);
        result_out : OUT unsigned(15 DOWNTO 0);
        reg_data, acumulador_data_out, output : OUT unsigned (15 DOWNTO 0)
    );
END ENTITY processador;

ARCHITECTURE a_processador OF processador IS
    COMPONENT ULA IS
        PORT (
            in_A : IN unsigned(15 DOWNTO 0);
            in_B : IN unsigned(15 DOWNTO 0);
            op : IN unsigned(1 DOWNTO 0);
            result : OUT unsigned(15 DOWNTO 0);
            zero, negative : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT banco_registradores IS
        PORT (
            sel_reg : IN unsigned (2 DOWNTO 0);
            sel_reg_write : IN unsigned (2 DOWNTO 0);
            write_data : IN unsigned (15 DOWNTO 0);
            write_enable, clk, rst : IN STD_LOGIC;
            reg_data : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT registrador
        PORT (
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            write_enable : in STD_LOGIC;
            write_data : in UNSIGNED(15 downto 0);
            read_data : out UNSIGNED(15 downto 0)
        );
    END COMPONENT;

    COMPONENT control_unit IS
        PORT (
            opcode : OUT unsigned(3 DOWNTO 0);
            clk, rst, branch_in : IN STD_LOGIC;
            state_out : OUT unsigned (1 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT flags_register IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        N_enable, Z_enable : IN STD_LOGIC;
        N_in, Z_in : IN STD_LOGIC;
        N_out, Z_out : OUT STD_LOGIC
    );
    END COMPONENT;

    COMPONENT ram IS
        PORT (
            clk : IN STD_LOGIC;
            address : IN unsigned(15 DOWNTO 0);
            wr_en : IN STD_LOGIC;
            data_in : IN unsigned(15 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL result_sig : unsigned(15 DOWNTO 0);
    SIGNAL zero_sig , negative_sig, Z, N : STD_LOGIC;
    SIGNAL opcode_sig : unsigned(3 DOWNTO 0);
    SIGNAL state : unsigned(1 DOWNTO 0);
    SIGNAL sel_reg_sig : unsigned(2 DOWNTO 0);
    SIGNAL reg_data_sig, ula_a_in, ula_b_in, acumulador_data : unsigned(15 DOWNTO 0);
    SIGNAL data_output : unsigned(15 DOWNTO 0);
    SIGNAL op_sig : unsigned(1 DOWNTO 0);
    SIGNAL write_data : unsigned(15 DOWNTO 0);
    SIGNAL write_en_reg : STD_LOGIC := '0';
    SIGNAL branch_sig : STD_LOGIC := '0';
    SIGNAL sel_reg_write : unsigned (2 DOWNTO 0);
    SIGNAL cte : unsigned (7 DOWNTO 0);
    SIGNAL mux_acumulador : unsigned(15 DOWNTO 0);
    SIGNAL en_N : STD_LOGIC := '0';
    SIGNAL en_Z : STD_LOGIC := '0';
    SIGNAL ram_data_in : unsigned(15 DOWNTO 0);
    SIGNAL ram_address : unsigned(15 DOWNTO 0);
    SIGNAL ram_data_out : unsigned(15 DOWNTO 0);
    SIGNAL ram_write_en : STD_LOGIC := '0';

BEGIN
    ula_inst : ULA
    PORT MAP(
        in_A => ula_a_in,
        in_B => ula_b_in,
        op => op_sig,
        result => result_sig,
        zero => zero_sig,
        negative => negative_sig
    );

    reg_bank_inst : banco_registradores
    PORT MAP(
        sel_reg => sel_reg_sig,
        sel_reg_write => sel_reg_write,
        write_data => write_data,
        write_enable => write_en_reg,
        clk => clk,
        rst => rst,
        reg_data => reg_data_sig
    );

    acumulador : registrador PORT MAP(
        clk => clk,
        rst => rst,
        write_enable => write_en_reg,
        write_data => mux_acumulador, 
        read_data => acumulador_data
    );
    
    control_unit_inst : control_unit
    PORT MAP(
        opcode => opcode_sig,
        clk => clk,
        rst => rst,
        branch_in => branch_sig,
        state_out => state,
        data_out => data_output
    );

    flags_reg : flags_register
    PORT MAP(
        clk => clk,
        rst => rst,
        N_enable => en_N,
        Z_enable => en_Z,
        N_in => negative_sig,
        Z_in => zero_sig,
        N_out => N,
        Z_out => Z
    );

    ram_inst : ram
    PORT MAP(
        clk => clk,
        address => ram_address,
        wr_en => ram_write_en,
        data_in => ram_data_in,
        data_out => ram_data_out
    );

    ram_write_en <= '1' WHEN opcode_sig = "0111" ELSE
        '0';

    ram_data_in <= acumulador_data;

    ram_address <= reg_data_sig WHEN data_output(4) = '0' AND (opcode_sig = "0111" or opcode_sig = "0110") else
                   acumulador_data WHEN data_output(4) = '1' AND (opcode_sig = "0111" or opcode_sig = "0110") ELSE
                   x"0000";

    write_en_reg <= '1' WHEN state = "10" ELSE
        '0';

    branch_sig <= '1' WHEN (opcode_sig = "1001" AND Z = '1' AND state = "00") else
                  '1' WHEN (opcode_sig = "1011" AND N = '1' AND state = "00") ELSE
                  '1' WHEN (opcode_sig = "1101" AND Z = '0' AND state = "00") else
                  '1' WHEN (opcode_sig = "1110" AND N = '0' AND state = "00") ELSE
                  branch_sig WHEN state = "00" ELSE
                  '0';

    op_sig <= "00" WHEN opcode_sig = "0011" ELSE
        "01" WHEN (opcode_sig = "0100" OR opcode_sig = "1100" OR opcode_sig = "1000") ELSE
        "00";

    en_Z <= '1' WHEN opcode_sig = "1000" ELSE '0';

    en_N <= '1' WHEN opcode_sig = "1000" ELSE '0';

    cte <= data_output(7 DOWNTO 0);

    sel_reg_sig <= to_unsigned(to_integer(data_output(11 DOWNTO 9)), 3) WHEN (opcode_sig = "0101") ELSE
                   to_unsigned(to_integer(data_output(7 DOWNTO 5)), 3);

    sel_reg_write <= to_unsigned(to_integer(data_output(11 DOWNTO 9)), 3);


    ula_a_in <= to_unsigned(to_integer(cte), 16) WHEN (opcode_sig = "1100") ELSE
                acumulador_data WHEN ((opcode_sig = "1000" OR opcode_sig = "0101") AND data_output(8) = '1') ELSE
                reg_data_sig;

    ula_b_in <= "0000000000000001" WHEN (opcode_sig = "0101") ELSE 
                acumulador_data;
    

    write_data <= acumulador_data WHEN (opcode_sig = "0010" AND data_output(4) = '1') ELSE 
                  to_unsigned(to_integer(cte), 16) WHEN (opcode_sig = "0001" AND data_output(8) = '0') else
                  ram_data_out WHEN (opcode_sig = "0110" AND data_output(8) = '0') else
                  result_sig WHEN (opcode_sig = "0101" AND data_output(8) = '0') ELSE
                  write_data;
    
    mux_acumulador <= reg_data_sig WHEN (opcode_sig = "0010" AND data_output(4) = '0') ELSE 
                      result_sig WHEN (opcode_sig = "0011" OR opcode_sig = "0100" OR opcode_sig = "1100" OR (opcode_sig = "0101" AND data_output(8) = '1') ) ELSE 
                      to_unsigned(to_integer(cte), 16) WHEN (opcode_sig = "0001" AND data_output(8) = '1') else
                      ram_data_out WHEN (opcode_sig = "0110" AND data_output(8) = '1') else
                      acumulador_data;

    result_out <= result_sig;
    opcode <= opcode_sig;
    state_out <= state;
    reg_data <= reg_data_sig;
    acumulador_data_out <= acumulador_data;
    output <= ram_data_out;
END ARCHITECTURE a_processador;