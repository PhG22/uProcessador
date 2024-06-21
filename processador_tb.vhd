LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY processador_tb IS
END ENTITY processador_tb;

ARCHITECTURE a_processador_tb OF processador_tb IS
    -- Component declaration
    COMPONENT processador
        PORT (
            clk, rst : IN STD_LOGIC;
            opcode : OUT unsigned(3 DOWNTO 0);
            state_out : OUT unsigned (1 DOWNTO 0);
            result_out : OUT unsigned(15 DOWNTO 0);
            reg_data, acumulador_data_out, output : OUT unsigned (15 DOWNTO 0)
        );
    END COMPONENT;

    -- Signal declarations
    SIGNAL clk, rst : STD_LOGIC;
    SIGNAL opcode_sig : unsigned(3 DOWNTO 0);
    SIGNAL state_out_sig : unsigned (1 DOWNTO 0);
    SIGNAL result_out_sig : unsigned(15 DOWNTO 0);
    SIGNAL reg_data_sig : unsigned (15 DOWNTO 0);
    SIGNAL acumulador_data_sig : unsigned (15 DOWNTO 0);
    SIGNAL ram_output_sig : unsigned (15 DOWNTO 0);

BEGIN
    uut : processador
    PORT MAP(
        clk => clk,
        rst => rst,
        opcode => opcode_sig,
        state_out => state_out_sig,
        result_out => result_out_sig,
        reg_data => reg_data_sig,
        acumulador_data_out => acumulador_data_sig,
        output => ram_output_sig
    );

    clk_process : PROCESS
    BEGIN
        WHILE now < 40000 ns LOOP
            clk <= '0';
            WAIT FOR 10 ns;
            clk <= '1';
            WAIT FOR 10 ns;
        END LOOP;
        WAIT;
    END PROCESS;

    -- Reset inicial
    reset_process : PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR 40 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

    test_process : PROCESS
    BEGIN
        WAIT;
    END PROCESS;

END ARCHITECTURE a_processador_tb;