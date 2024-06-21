LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ram IS
    PORT (
        clk : IN STD_LOGIC;
        address : IN unsigned(15 DOWNTO 0);
        wr_en : IN STD_LOGIC;
        data_in : IN unsigned(15 DOWNTO 0);
        data_out : OUT unsigned(15 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_ram OF ram IS
    TYPE mem IS ARRAY (0 TO 512) OF unsigned(15 DOWNTO 0);
    SIGNAL ram_content : mem;
BEGIN
    PROCESS (clk, wr_en)
    BEGIN
        IF rising_edge(clk) THEN
            IF wr_en = '1' THEN
                ram_content(to_integer(address)) <= data_in;
            END IF;
        END IF;
    END PROCESS;
    data_out <= ram_content(to_integer(address));
END ARCHITECTURE;