LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control_unit_tb IS
END ENTITY control_unit_tb;

ARCHITECTURE a_control_unit_tb OF control_unit_tb IS
    COMPONENT control_unit IS
        PORT (
            opcode : OUT unsigned(3 DOWNTO 0);
            clk, rst : IN STD_LOGIC;
            state_out : OUT unsigned (1 DOWNTO 0);
            data_out : OUT unsigned(15 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL rst : STD_LOGIC := '0';
    SIGNAL data_out : unsigned(15 DOWNTO 0);
    SIGNAL state_out : unsigned(1 DOWNTO 0);
    SIGNAL opcode : unsigned(3 DOWNTO 0);

BEGIN
    uut : control_unit PORT MAP (
        opcode => opcode,
        clk => clk,
        rst => rst,
        state_out => state_out,
        data_out => data_out
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
        WAIT FOR 20 ns;
        rst <= '0';
        WAIT;
    END PROCESS;

    test_process : PROCESS
    BEGIN
        WAIT;
    END PROCESS;

END ARCHITECTURE a_control_unit_tb;
