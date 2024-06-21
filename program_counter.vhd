LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY program_counter IS
    PORT (
        clk, write_enable, rst, branch : IN STD_LOGIC;
        data_in, address : IN unsigned(15 DOWNTO 0);
        data_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY program_counter;

ARCHITECTURE a_program_counter OF program_counter IS
    SIGNAL sig_data : unsigned(15 DOWNTO 0) := (OTHERS => '0');
    SIGNAL sig_plus : unsigned(15 DOWNTO 0);

BEGIN
    sig_plus <= sig_data + 1;

    PROCESS (clk)
    BEGIN
        IF rst = '1' THEN
            sig_data <= x"0000";
        ELSIF write_enable = '1' THEN
            IF rising_edge(clk) THEN
                IF branch = '1' THEN
                    sig_data <= address;
                ELSE
                    sig_data <= sig_plus;
                END IF;
            END IF;
        END IF;
    END PROCESS;

    data_out <= sig_data;

END ARCHITECTURE a_program_counter;