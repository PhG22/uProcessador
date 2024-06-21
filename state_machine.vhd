LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY state_machine IS
    PORT (
        clk, rst : IN STD_LOGIC;
        state : OUT unsigned(1 DOWNTO 0)
    );
END state_machine;

ARCHITECTURE a_state_machine OF state_machine IS
    SIGNAL output : unsigned(1 DOWNTO 0);
BEGIN
    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            output <= "00";
        ELSIF rising_edge(clk) THEN
            IF output = "10" THEN
                output <= "00";
            ELSE
                output <= output + 1;
            END IF;
        END IF;
    END PROCESS;
    state <= output;
END a_state_machine;