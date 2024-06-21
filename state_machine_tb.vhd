LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY state_machine_tb IS
END state_machine_tb;

ARCHITECTURE a_state_machine_tb OF state_machine_tb IS

    SIGNAL clk, rst : STD_LOGIC := '0';
    SIGNAL state : UNSIGNED(1 DOWNTO 0) := (OTHERS => '0');

    COMPONENT state_machine
        PORT (
            clk, rst : IN STD_LOGIC;
            state : OUT UNSIGNED(1 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    uut : state_machine
    PORT MAP(
        clk => clk,
        rst => rst,
        state => state
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

END a_state_machine_tb;