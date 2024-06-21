LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY flags_register IS
    PORT (
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        N_enable, Z_enable : IN STD_LOGIC;
        N_in, Z_in : IN STD_LOGIC;
        N_out, Z_out : OUT STD_LOGIC
    );
END ENTITY;

ARCHITECTURE a_flags_register OF flags_register IS
    SIGNAL N, Z : STD_LOGIC := ('0');
BEGIN

    PROCESS (clk, rst)
    BEGIN
        IF rst = '1' THEN
            N <= '0';
            Z <= '0';
        ELSE
            IF N_enable = '1' THEN
                IF rising_edge(clk) THEN
                    N <= N_in;
                END IF;
            END IF;
            IF Z_enable = '1' THEN
                IF rising_edge(clk) THEN
                    Z <= Z_in;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    N_out <= N;
    Z_out <= Z;
END ARCHITECTURE;