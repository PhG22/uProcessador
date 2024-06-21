LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY program_counter_tb IS
END program_counter_tb;

ARCHITECTURE a_program_counter_tb OF program_counter_tb IS

    COMPONENT program_counter IS
        PORT (
            clk, write_enable, rst, branch : IN STD_LOGIC;
            data_out : OUT unsigned(15 DOWNTO 0);
            data_in, address : IN unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';
    SIGNAL branch : STD_LOGIC := '0';
    SIGNAL write_enable : STD_LOGIC := '1';
    SIGNAL data_out : unsigned(15 DOWNTO 0);
    SIGNAL address : unsigned(15 DOWNTO 0);
    SIGNAL data_in : unsigned(15 DOWNTO 0) := (others => '0');

BEGIN

    uut : program_counter
    PORT MAP(
        clk => clk,
        write_enable => write_enable,
        rst => rst,
        branch => branch,
        data_out => data_out,
        address => address,
        data_in => data_in
    );

    clk_process : PROCESS
    BEGIN
        WHILE now < 1000 ns LOOP
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
        WAIT FOR 100 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

    test_process : PROCESS
    BEGIN
        WAIT;
    END PROCESS;
END a_program_counter_tb;